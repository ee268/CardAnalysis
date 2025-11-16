#ifndef SINGLETON_H
#define SINGLETON_H
#include <iostream>
#include <memory>
#include <thread>
#include <mutex>

template <typename T>
class Singleton {
protected:
	Singleton() = default;
	Singleton(const Singleton<T>&) = delete;
	Singleton& operator=(const Singleton<T>& st) = delete;

	static std::shared_ptr<T> _instance;

public:
	static std::shared_ptr<T> GetInstance() {
		//不管调用几次，初始化都只有一次
		static std::once_flag s_flag;//第二次调用开始，s_flag为true
		std::call_once(s_flag, [&]() {
			_instance = std::shared_ptr <T>(new T);
			//直接使用new而不是make_shared，
			//是因为单例类模板的构造函数的protected的，无法被make_shared访问
			//使用new就可以跳过单例模板类的构造函数，直接调用T的构造
			});

		return _instance;
	}

	void PrintAddress() {
		std::cout << _instance.get() << std::endl;
	}

	~Singleton() {
		std::cout << "this is singleton destruct" << std::endl;
	}
};

template <typename T>
std::shared_ptr<T> Singleton<T>::_instance = nullptr;//类内声明，类外初始化

#endif // !SINGLETON_H
