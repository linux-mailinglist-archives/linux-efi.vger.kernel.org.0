Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA96C1393FE
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2020 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMOxc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jan 2020 09:53:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35918 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMOxb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jan 2020 09:53:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id n184so6207779ywc.3;
        Mon, 13 Jan 2020 06:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWmNQjvuX9zJ6z0ZcNWGk9QjxjID7F47ltFXDEuoyJw=;
        b=KuISl8anpqsedhLi4oTf62YMROo851MNeTMEzY2Q8zpix+hmYoBl8kJrFC92nvz9qM
         i8Qdxqh9Evv649mi6nlWZdSdasSoLaZpsvSGZ4IXhigwARdQTvS1rVzrKdECuJd6GPoC
         pD0Md9tuJ8KOnKeiugprI33ENVopxEn1i+If2wr7TjHietKC+lsCCXuaVfKp8w1Gq5Sg
         f5DkqjUybaXYGM09jZWQP8YDVaJ5pQPgrwm4dPKxCrrQVRnzQAdU/9MmojetjkogG+MN
         kmNsDUxL51yzYalDqXMAXhomHRZ8Hh++if1RK9ORpAR0vcQHvM0OfVRlw/q/1fA75d62
         gV9A==
X-Gm-Message-State: APjAAAWKuMdilVO1RY4KUxxE5SaX6oHOUgZvCNT6AJ2hfMZ2d4sAkK/J
        IYQ0xV8QHir2djDqZGqwQ4w=
X-Google-Smtp-Source: APXvYqzIKDnngH4Et6AZ6y2I+FvMl/cZfena1h9B3Jr7aE7gC3QwWC04QUyGSx/Gqnnuyrmf8U3Trg==
X-Received: by 2002:a25:24f:: with SMTP id 76mr13616157ybc.330.1578927210604;
        Mon, 13 Jan 2020 06:53:30 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i84sm5189537ywc.43.2020.01.13.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 06:53:29 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1BDDE4018C; Mon, 13 Jan 2020 14:53:28 +0000 (UTC)
Date:   Mon, 13 Jan 2020 14:53:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH v11 05/10] test_firmware: add support for
 firmware_request_platform
Message-ID: <20200113145328.GA11244@42.do-not-panic.com>
References: <20200111145703.533809-1-hdegoede@redhat.com>
 <20200111145703.533809-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111145703.533809-6-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 11, 2020 at 03:56:58PM +0100, Hans de Goede wrote:
> Add support for testing firmware_request_platform through a new
> trigger_request_platform trigger.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v11:
> - Drop a few empty lines which were accidentally introduced

But you didn't address my other feedback.

> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -507,6 +508,61 @@ static ssize_t trigger_request_store(struct device *dev,
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

I mentioned this in my last review, and it seems you forgot to address
this. But now some more feedback:

These two:

> +	mutex_lock(&test_fw_mutex);
> +	release_firmware(test_firmware);

You are doing this because this is a test, but a typical driver will
do this after, and we don't loose anything in doing this after. Can you
move the mutex lock and assign the pointer to a temporary used pointer
for the call, *after* your call.

But since your test is not using any interfaces to query information
about the firmware, and you are just doing the test in C code right
away, instead of say, using a trigger for later use in userspace,
you can just do away with the mutex lock and make the call use its
own pointer:

	rc = firmware_request_platform(&tmp_test_firmware, name, dev);
	if (rc) {
		...
	}
	/* Your test branch code goes here */

I see no reason why you use the test_firmware pointer.

> +	test_firmware = NULL;
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
> +
> +out:
> +	mutex_unlock(&test_fw_mutex);
> +
> +	list_del(&fw.list);
> +	kfree(name);
> +
> +	return rc;
> +}
