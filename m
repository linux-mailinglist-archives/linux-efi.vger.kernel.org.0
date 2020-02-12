Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9215A822
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2020 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgBLLol (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Feb 2020 06:44:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbgBLLol (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Feb 2020 06:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BQVXhL1HNjiwkDYLZsJpW7zx0/CnX2KFIpUSNf+SiDI=;
        b=RlagzGcrVM04jW/YSrGrJxKM9H8IwEJqdj6a6oXcHRXUrNOLAg1aoYm+u2uaJVDrLTM77s
        dUxHhy3pGE6uWfJgg1/cdhBffsjGQD4ltjxHpT2eooX/Z09ZtW4p/kn+L2tnUqX+C+2c/p
        aR4231753CLgPTp2DzzPH/JNE4oAlds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-_QYI63lPPk-0bR_skscyhQ-1; Wed, 12 Feb 2020 06:44:37 -0500
X-MC-Unique: _QYI63lPPk-0bR_skscyhQ-1
Received: by mail-wm1-f72.google.com with SMTP id f207so837093wme.6
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 03:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BQVXhL1HNjiwkDYLZsJpW7zx0/CnX2KFIpUSNf+SiDI=;
        b=KsZSwlpSVGHADt4CtLlmzNF0fH9bY0z09+hUbUgUa+cpOJ5Z84TICbzOocmKaBexjn
         ZgokvE2ag0Fz/yWqMDvYexDht9+r2iWtumVxxIO47suljrJ01D+OMQDT6Q/1aOvzvcsc
         c90o8oyNsXqlDmESaWasFLQ6opAGgunqcG3vfdkrfqE8/z3XBsRgKtI85XKy5qIro7Gt
         blmL0Wukq1uhIBrqeMI16IIpVLwoI+FP0f8VjIq+DUj2fz6mXxkdExyXder1bEg8x9Fr
         l2Gv7k85TU+Segq8LTVm3oA0bK6X9jBXIXBpZdquD2Mrrme8Mhg8/pJ3hbR8tvw2KdT5
         FJHQ==
X-Gm-Message-State: APjAAAUTizbgh2kRftFgdfHH5f5qEb+x+a+mW3jB92KLEnTEQ15AxsVa
        dsx1dFdfo1RJzzhY9z8slf9UyaGVKsTm8XNm+NGhuVhMMbzrpG5YVhnuE1B8OM6JZBHmpX1ocns
        klDRHxPiHxOPj2d227Dgj
X-Received: by 2002:a7b:c416:: with SMTP id k22mr12870233wmi.10.1581507876166;
        Wed, 12 Feb 2020 03:44:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbvWplwSpvkAXvaSwHQKYRDZdV6cxuxu3vn9tQJP1ivxbxtnhYLjd/imFAyQdkakQJBpVrBA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr12870217wmi.10.1581507875968;
        Wed, 12 Feb 2020 03:44:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id q124sm10497222wme.2.2020.02.12.03.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:44:35 -0800 (PST)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
Message-ID: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
Date:   Wed, 12 Feb 2020 12:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

While booting 5.6-rc1 on one of my test machines I noticed the WARN_ON
on line 198 of arch/x86/platform/efi/efi_64.c trigger many times.

I've done some debugging on this an this is caused by the following
call path:

drivers/firmware/efi/vars.c: efivar_init():

         unsigned long variable_name_size = 1024;
         efi_char16_t *variable_name;
         efi_guid_t vendor_guid;

         variable_name = kzalloc(variable_name_size, GFP_KERNEL);
         if (!variable_name) {
                 printk(KERN_ERR "efivars: Memory allocation failed.\n");
                 return -ENOMEM;
         }

	...


         do {
                 variable_name_size = 1024;

                 status = ops->get_next_variable(&variable_name_size,
                                                 variable_name,
                                                 &vendor_guid);
	...

arch/x86/platform/efi/efi_64.c: efi_thunk_get_next_variable()

	...
         phys_vendor = virt_to_phys_or_null(vendor);
	...

arch/x86/platform/efi/efi_64.c: virt_to_phys_or_null_size()

	...
	WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
	...

Specifically the problem is that the efi_guid_t vendor_guid has an 8 bytes
aligned address and the WARN_ON checks for it being aligned to\
sizeof(efi_guid_t) which is 16 bytes.

I've fixed this for now with the following local fix, but I'm not sure
what the alignment rules actually are so I'm not sure this is correct:

--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -181,6 +181,7 @@ static inline phys_addr_t
  virt_to_phys_or_null_size(void *va, unsigned long size)
  {
  	bool bad_size;
+	int alignment;

  	if (!va)
  		return 0;
@@ -195,7 +196,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
  	 */
  	bad_size = size > PAGE_SIZE || !is_power_of_2(size);

-	WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
+	alignment = size > 8 ? 8 : size;
+	WARN_ON(!IS_ALIGNED((unsigned long)va, alignment) || bad_size);

  	return slow_virt_to_phys(va);
  }


I have a feeling that this is the right thing to do, but as said I'm not 100%
sure. If you can confirm that this is the right fix, then I can submit this
upstream.

Regards,

Hans

