// Generated by gencpp from file single_actuator/gravity_current.msg
// DO NOT EDIT!


#ifndef SINGLE_ACTUATOR_MESSAGE_GRAVITY_CURRENT_H
#define SINGLE_ACTUATOR_MESSAGE_GRAVITY_CURRENT_H

#include <ros/service_traits.h>


#include <single_actuator/gravity_currentRequest.h>
#include <single_actuator/gravity_currentResponse.h>


namespace single_actuator
{

struct gravity_current
{

typedef gravity_currentRequest Request;
typedef gravity_currentResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct gravity_current
} // namespace single_actuator


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::single_actuator::gravity_current > {
  static const char* value()
  {
    return "ca4d0ba43a70fe6e37b76accdbf3ef40";
  }

  static const char* value(const ::single_actuator::gravity_current&) { return value(); }
};

template<>
struct DataType< ::single_actuator::gravity_current > {
  static const char* value()
  {
    return "single_actuator/gravity_current";
  }

  static const char* value(const ::single_actuator::gravity_current&) { return value(); }
};


// service_traits::MD5Sum< ::single_actuator::gravity_currentRequest> should match
// service_traits::MD5Sum< ::single_actuator::gravity_current >
template<>
struct MD5Sum< ::single_actuator::gravity_currentRequest>
{
  static const char* value()
  {
    return MD5Sum< ::single_actuator::gravity_current >::value();
  }
  static const char* value(const ::single_actuator::gravity_currentRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::single_actuator::gravity_currentRequest> should match
// service_traits::DataType< ::single_actuator::gravity_current >
template<>
struct DataType< ::single_actuator::gravity_currentRequest>
{
  static const char* value()
  {
    return DataType< ::single_actuator::gravity_current >::value();
  }
  static const char* value(const ::single_actuator::gravity_currentRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::single_actuator::gravity_currentResponse> should match
// service_traits::MD5Sum< ::single_actuator::gravity_current >
template<>
struct MD5Sum< ::single_actuator::gravity_currentResponse>
{
  static const char* value()
  {
    return MD5Sum< ::single_actuator::gravity_current >::value();
  }
  static const char* value(const ::single_actuator::gravity_currentResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::single_actuator::gravity_currentResponse> should match
// service_traits::DataType< ::single_actuator::gravity_current >
template<>
struct DataType< ::single_actuator::gravity_currentResponse>
{
  static const char* value()
  {
    return DataType< ::single_actuator::gravity_current >::value();
  }
  static const char* value(const ::single_actuator::gravity_currentResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SINGLE_ACTUATOR_MESSAGE_GRAVITY_CURRENT_H
