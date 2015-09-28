${remoteClass.name}Internal.cpp
/* Autogenerated with kurento-module-creator */

#include <iostream>
#include "${remoteClass.name}Internal.hpp"
#include <KurentoException.hpp>
#include <jsonrpc/JsonSerializer.hpp>
<#list typeDependencies(remoteClass) as dependency>
#include "${dependency.name}.hpp"
</#list>

<#list module.code.implementation["cppNamespace"]?split("::") as namespace>
namespace ${namespace}
{
</#list>

<#list remoteClass.methods as method><#rt>
${getCppObjectType(method.return, false)} ${remoteClass.name}Method${method.name?cap_first}::invoke (std::shared_ptr<${remoteClass.name}> obj)
{
  if (!obj) {
    throw KurentoException (MEDIA_OBJECT_NOT_FOUND, "Invalid object while invoking method ${remoteClass.name}::${method.name}");
  }

  <#list method.params as param>
  <#if param.optional>
  <#assign optionalParam = param>
  if (!__isSet${param.name?cap_first}) {
    return obj->${method.name} (<#rt>
    <#lt><#list method.params as param>
      <#lt><#if optionalParam == param><#break></#if><#if param_index != 0>, </#if>${param.name}<#rt>
    <#lt></#list>);
  }

  </#if>
  </#list>
  return obj->${method.name} (<#rt>
    <#lt><#list method.params as param>
      <#lt><#if param_index != 0>, </#if>${param.name}<#rt>
    <#lt></#list>);
}

void ${remoteClass.name}Method${method.name?cap_first}::Serialize (kurento::JsonSerializer &s)
{
  if (s.IsWriter) {
  <#list method.params as param>
    <#if param.optional>
    if (__isSet${param.name?cap_first}) {
      s.SerializeNVP (${param.name});
    }

    <#else>
    s.SerializeNVP (${param.name});

    </#if>
  </#list>
  } else {
  <#assign requiredParams = false>
  <#list method.params as param>
    <#if !param.optional>
    <#assign requiredParams = true>
    </#if>
  </#list>
  <#if requiredParams>
    if (s.JsonValue.isNull ()) {
      throw KurentoException (MARSHALL_ERROR,
                              "'operationParams' is required");
    } else if (!s.JsonValue.isObject ()){
      throw KurentoException (MARSHALL_ERROR,
                              "'operationParams' should be an object");
    }
  <#else>
    if (!s.JsonValue.isNull () && !s.JsonValue.isObject ()) {
      throw KurentoException (MARSHALL_ERROR,
                              "'operationParams' should be an object");
    }
  </#if>

  <#list method.params as param>
    <#assign jsonData = getJsonCppTypeData(param.type)>
    <#if param.optional>
    if (s.JsonValue.isMember ("${param.name}") ) {
      if (s.JsonValue["${param.name}"].isConvertibleTo (Json::ValueType::${jsonData.getJsonValueType()}) ) {
        __isSet${param.name?cap_first} = true;
        s.SerializeNVP (${param.name});
      } else {
        throw KurentoException (MARSHALL_ERROR,
                                "'${param.name}' parameter should be a ${jsonData.getTypeDescription()}");
      }
    }

    <#else>
    if (!s.JsonValue.isMember ("${param.name}") || !s.JsonValue["${param.name}"].isConvertibleTo (Json::ValueType::${jsonData.getJsonValueType()}) ) {
      throw KurentoException (MARSHALL_ERROR,
                              "'${param.name}' parameter should be a ${jsonData.getTypeDescription()}");
    }

    s.SerializeNVP (${param.name});

    </#if>
  </#list>
  }
}

</#list>
<#if remoteClass.constructor??><#rt>
<#list remoteClass.constructor.params as param>
${getCppObjectType (param.type, false)} ${remoteClass.name}Constructor::get${param.name?cap_first} ()
{
  <#if param.optional>
  <#if param.defaultValue?? >
  if (!__isSet${param.name?cap_first} && !__isSetDefault${param.name?cap_first}) {
    try {
      kurento::JsonSerializer s (false);
      Json::Reader reader;
      std::string defaultValue = "${escapeString (param.defaultValue)}";

      reader.parse (defaultValue, s.JsonValue["${param.name}"]);
      s.SerializeNVP (${param.name});
      __isSetDefault${param.name?cap_first} = true;
    } catch (std::exception &e) {
      std::cerr << "Unexpected exception deserializing default value ${param.name} of ${remoteClass.name} constructor, check your module: " << e.what() << std::endl;
    }
  }

  <#else>
#error "${param.name} optional param must have a default value"
  </#if>
  </#if>
  return ${param.name};
}

</#list>
void ${remoteClass.name}Constructor::Serialize (kurento::JsonSerializer &s)
{
  if (s.IsWriter) {
  <#list remoteClass.constructor.params as param>
    <#if param.optional>
    if (__isSet${param.name?cap_first}) {
      s.SerializeNVP (${param.name});
    }

    <#else>
    s.SerializeNVP (${param.name});

    </#if>
  </#list>
  } else {
  <#assign requiredParams = false>
  <#list remoteClass.constructor.params as param>
    <#if !param.optional>
    <#assign requiredParams = true>
    </#if>
  </#list>
  <#if requiredParams>
    if (s.JsonValue.isNull ()) {
      throw KurentoException (MARSHALL_ERROR,
                              "'constructorParams' is required");
    } else if (!s.JsonValue.isObject ()){
      throw KurentoException (MARSHALL_ERROR,
                              "'constructorParams' should be an object");
    }
  <#else>
    if (!s.JsonValue.isNull () && !s.JsonValue.isObject ()) {
      throw KurentoException (MARSHALL_ERROR,
                              "'constructorParams' should be an object");
    }
  </#if>

  <#list remoteClass.constructor.params as param>
    <#assign jsonData = getJsonCppTypeData(param.type)>
    <#if param.optional>
    if (s.JsonValue.isMember ("${param.name}") ) {
      if (s.JsonValue["${param.name}"].isConvertibleTo (Json::ValueType::${jsonData.getJsonValueType()}) ) {
        __isSet${param.name?cap_first} = true;
        s.SerializeNVP (${param.name});
      } else {
        throw KurentoException (MARSHALL_ERROR,
                                "'${param.name}' parameter should be a ${jsonData.getTypeDescription()}");
      }
    }

    <#else>
    if (!s.JsonValue.isMember ("${param.name}") || !s.JsonValue["${param.name}"].isConvertibleTo (Json::ValueType::${jsonData.getJsonValueType()}) ) {
      throw KurentoException (MARSHALL_ERROR,
                              "'${param.name}' parameter should be a ${jsonData.getTypeDescription()}");
    }

    s.SerializeNVP (${param.name});

    </#if>
  </#list>
  }
}

</#if>
<#list module.code.implementation["cppNamespace"]?split("::")?reverse as namespace>
} /* ${namespace} */
</#list>
