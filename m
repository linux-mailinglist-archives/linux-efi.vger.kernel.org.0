Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0611B131A7F
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2020 22:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgAFVdt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jan 2020 16:33:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgAFVdp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jan 2020 16:33:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so27438011pgl.11;
        Mon, 06 Jan 2020 13:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YlYKPHpunNCuwNpgLXYWk+P5gDqWSvQ71BDe2+/jE4=;
        b=N4j72bn0hNdQItfQfGkUaTpmwnyqrKkNrlAvj+xLTnxu0NQOeTbQBdk8DD0BDQ2yoQ
         VzpltOJInN7hJSuF+ZgbeDJDcsQOidcI2NRZxXd4AMMikmHn5WyqmrBhkSS+1q/7eRSS
         m+N3VndZbyQWIuZk5fogbxkxQj4XsUtQPYbSMBDG6PmuXf3yRB1gkPINkLw7Fu2t8jzd
         NO/LvfCrSHlO7z6cKEDHSwTqZw4n4wT0CYaH/P7qqOEQbCPa3MYJ/SvHDPAAtggE3Sy7
         cx4oAL0/SUKjwFomEwttomNiBm49+LNnJTI4S7UVOljDpB5/CB8OO6noiiPr2laRgR+M
         Ry0A==
X-Gm-Message-State: APjAAAUKzidBXOlevtkaqHg50aeyzIxbWL5KwbG0V9ZZf3A4Wtjg5C+W
        qNir5xZQuw24l/uXO3Hj0Rk=
X-Google-Smtp-Source: APXvYqwGiPQYAYwL9vWqDpJIl1HKxVMoDt4Ev4E/5klzEl3TNuNV/EZy4Blrnh13RzpOm/I800S+Nw==
X-Received: by 2002:aa7:8e13:: with SMTP id c19mr76663440pfr.227.1578346424985;
        Mon, 06 Jan 2020 13:33:44 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 11sm81070528pfz.25.2020.01.06.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 13:33:43 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1E46040321; Mon,  6 Jan 2020 21:33:43 +0000 (UTC)
Date:   Mon, 6 Jan 2020 21:33:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: Re: [PATCH v10 05/10] test_firmware: add support for
 firmware_request_platform
Message-ID: <20200106213343.GV11244@42.do-not-panic.com>
References: <20191210115117.303935-1-hdegoede@redhat.com>
 <20191210115117.303935-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210115117.303935-6-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 10, 2019 at 12:51:12PM +0100, Hans de Goede wrote:
> Add support for testing firmware_request_platform through a new
> trigger_request_platform trigger.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  lib/test_firmware.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 251213c872b5..9af00cfc8979 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -24,6 +24,7 @@
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/vmalloc.h>
> +#include <linux/efi_embedded_fw.h>
>  
>  #define TEST_FIRMWARE_NAME	"test-firmware.bin"
>  #define TEST_FIRMWARE_NUM_REQS	4
> @@ -507,12 +508,76 @@ static ssize_t trigger_request_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(trigger_request);
>  
> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
> +static ssize_t trigger_request_platform_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	static const u8 test_data[] = {
> +		0x55, 0xaa, 0x55, 0xaa, 0x01, 0x02, 0x03, 0x04,
> +		0x55, 0xaa, 0x55, 0xaa, 0x05, 0x06, 0x07, 0x08,
> +		0x55, 0xaa, 0x55, 0xaa, 0x10, 0x20, 0x30, 0x40,
> +		0x55, 0xaa, 0x55, 0xaa, 0x50, 0x60, 0x70, 0x80
> +	};
> +	struct efi_embedded_fw fw;
> +	int rc;
> +	char *name;
> +
> +	name = kstrndup(buf, count, GFP_KERNEL);
> +	if (!name)
> +		return -ENOSPC;
> +
> +	pr_info("inserting test platform fw '%s'\n", name);
> +	fw.name = name;
> +	fw.data = (void *)test_data;
> +	fw.length = sizeof(test_data);
> +	list_add(&fw.list, &efi_embedded_fw_list);
> +
> +	pr_info("loading '%s'\n", name);
> +
> +	mutex_lock(&test_fw_mutex);
> +	release_firmware(test_firmware);
> +	test_firmware = NULL;

Seems odd to have the above two lines here before the request, why not
after as noted below.

> +	rc = firmware_request_platform(&test_firmware, name, dev);
> +	if (rc) {
> +		pr_info("load of '%s' failed: %d\n", name, rc);
> +		goto out;
> +	}
> +	if (test_firmware->size != sizeof(test_data) ||
> +	    memcmp(test_firmware->data, test_data, sizeof(test_data)) != 0) {
> +		pr_info("firmware contents mismatch for '%s'\n", name);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	pr_info("loaded: %zu\n", test_firmware->size);
> +	rc = count;

Here.

> +
> +out:
> +	mutex_unlock(&test_fw_mutex);
> +
> +	list_del(&fw.list);
> +	kfree(name);
> +
> +	return rc;
> +}
> +static DEVICE_ATTR_WO(trigger_request_platform);
> +#endif
> +
>  static DECLARE_COMPLETION(async_fw_done);
>  
>  static void trigger_async_request_cb(const struct firmware *fw, void *context)
>  {
>  	test_firmware = fw;
>  	complete(&async_fw_done);
> +
> +
> +
> +
> +
> +
> +
> +
> +
>  }

Ummm, new empty lines without any code added... did you forget
something?  Please address this.

  Luis
