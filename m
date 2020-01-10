Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4270013777D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2020 20:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAJTtE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jan 2020 14:49:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32561 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgAJTtD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jan 2020 14:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578685742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riUDIprs0OHwhmObTROTPPNxIryJYavnWepv59WA+CA=;
        b=SaBtyU8DbWUjGZ0O6fPM3bo7b2GE4337uelIOiOXYHV49ClkppzA7kN6YIIgLQjP1mffJh
        9fx02z/H3UpjvwrLki+2H2fDueFaoTETLsmv7ndvQATiw3Cgy5s/x/51YVszfC3XL/YcRM
        X5WS9PdQYGpYdeFS1CSj20CpGkX2vVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-zi3O7waxNYGDXHV-Kn40bw-1; Fri, 10 Jan 2020 14:48:57 -0500
X-MC-Unique: zi3O7waxNYGDXHV-Kn40bw-1
Received: by mail-wm1-f71.google.com with SMTP id b9so1232199wmj.6
        for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2020 11:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riUDIprs0OHwhmObTROTPPNxIryJYavnWepv59WA+CA=;
        b=uAMq1G0rbv64lPMUoR3VbqtUbn0JczsV2CHOQ/svakhKqhYfNbKq6D38Hub2DflCtp
         YXFQvu13ZuVYIxs4mXx06YB8Vdcm9dkMrGDGPmFMElqhulKleIkVF2NZXUus3l0OPu09
         SFfWFhGWAJMV24ZamOB2LKhd+rBgG2G+PY09X1MP37J+rUCKGVscNzbdLTodaIxFdxCR
         hUOcixP3JDVCKnvknT9/6NDpPkbB4IsrrSm/ora/tUVyxWqD6K4shV8nc2abrc3K58AS
         QLias51a/No+y+8sPiwcPxfqozvRIuQMOVUkM+5wRwOSKshO9319PhoVYLAm/n0mFVBs
         zASA==
X-Gm-Message-State: APjAAAUlzGHHBPAA5pD8tuvmTt5yq/pc9Xn3jtuj+VmGsevkOIdWbeYs
        +fAZPH29IdiVLJqsAlZy00AanIqqsZFAWc6MkuU2QqR76o3YcseGW0MtqRnCgNFOyIldwtQ4TiU
        KhMevoz1TTfZ7z0y4rhHM
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr4963223wru.52.1578685736124;
        Fri, 10 Jan 2020 11:48:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxnkUfoP+uLL1SY4zC1FGF5vm1kFUOUl7yLkO6Ifz3AOpkkYChb29i69nRMpO6ILyWjfQK53w==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr4963192wru.52.1578685735822;
        Fri, 10 Jan 2020 11:48:55 -0800 (PST)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id f17sm3450764wmc.8.2020.01.10.11.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 11:48:55 -0800 (PST)
Subject: Re: [PATCH v10 05/10] test_firmware: add support for
 firmware_request_platform
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191210115117.303935-1-hdegoede@redhat.com>
 <20191210115117.303935-6-hdegoede@redhat.com>
 <20200106213343.GV11244@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <071db8c5-4be1-c6d1-0ccb-a2268cd5b347@redhat.com>
Date:   Fri, 10 Jan 2020 20:48:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200106213343.GV11244@42.do-not-panic.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 1/6/20 10:33 PM, Luis Chamberlain wrote:
> On Tue, Dec 10, 2019 at 12:51:12PM +0100, Hans de Goede wrote:
>> Add support for testing firmware_request_platform through a new
>> trigger_request_platform trigger.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   lib/test_firmware.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>
>> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
>> index 251213c872b5..9af00cfc8979 100644
>> --- a/lib/test_firmware.c
>> +++ b/lib/test_firmware.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/kthread.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/efi_embedded_fw.h>
>>   
>>   #define TEST_FIRMWARE_NAME	"test-firmware.bin"
>>   #define TEST_FIRMWARE_NUM_REQS	4
>> @@ -507,12 +508,76 @@ static ssize_t trigger_request_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_WO(trigger_request);
>>   
>> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
>> +static ssize_t trigger_request_platform_store(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t count)
>> +{
>> +	static const u8 test_data[] = {
>> +		0x55, 0xaa, 0x55, 0xaa, 0x01, 0x02, 0x03, 0x04,
>> +		0x55, 0xaa, 0x55, 0xaa, 0x05, 0x06, 0x07, 0x08,
>> +		0x55, 0xaa, 0x55, 0xaa, 0x10, 0x20, 0x30, 0x40,
>> +		0x55, 0xaa, 0x55, 0xaa, 0x50, 0x60, 0x70, 0x80
>> +	};
>> +	struct efi_embedded_fw fw;
>> +	int rc;
>> +	char *name;
>> +
>> +	name = kstrndup(buf, count, GFP_KERNEL);
>> +	if (!name)
>> +		return -ENOSPC;
>> +
>> +	pr_info("inserting test platform fw '%s'\n", name);
>> +	fw.name = name;
>> +	fw.data = (void *)test_data;
>> +	fw.length = sizeof(test_data);
>> +	list_add(&fw.list, &efi_embedded_fw_list);
>> +
>> +	pr_info("loading '%s'\n", name);
>> +
>> +	mutex_lock(&test_fw_mutex);
>> +	release_firmware(test_firmware);
>> +	test_firmware = NULL;
> 
> Seems odd to have the above two lines here before the request, why not
> after as noted below.

I modelled this after trigger_request_store which keeps the
test_firmware around after it has been called so that its contents can be
read back from the char misc device which the test_firmware module registers.

Since e.g. trigger_request_store which keeps the test_firmware around
we must check and free it before assigning a new firmware to it using
firmware_request_platform, which is why this is done before and not
after the request.

> 
>> +	rc = firmware_request_platform(&test_firmware, name, dev);
>> +	if (rc) {
>> +		pr_info("load of '%s' failed: %d\n", name, rc);
>> +		goto out;
>> +	}
>> +	if (test_firmware->size != sizeof(test_data) ||
>> +	    memcmp(test_firmware->data, test_data, sizeof(test_data)) != 0) {
>> +		pr_info("firmware contents mismatch for '%s'\n", name);
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
>> +	pr_info("loaded: %zu\n", test_firmware->size);
>> +	rc = count;
> 
> Here.
> 
>> +
>> +out:
>> +	mutex_unlock(&test_fw_mutex);
>> +
>> +	list_del(&fw.list);
>> +	kfree(name);
>> +
>> +	return rc;
>> +}
>> +static DEVICE_ATTR_WO(trigger_request_platform);
>> +#endif
>> +
>>   static DECLARE_COMPLETION(async_fw_done);
>>   
>>   static void trigger_async_request_cb(const struct firmware *fw, void *context)
>>   {
>>   	test_firmware = fw;
>>   	complete(&async_fw_done);
>> +
>> +
>> +
>> +
>> +
>> +
>> +
>> +
>> +
>>   }
> 
> Ummm, new empty lines without any code added... did you forget
> something?  Please address this.

This is a left over from an earlier version of the patch, my bad, I will remove
this and send out a new version.

Regards,

Hans

