Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2535981D7
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiHRLAl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbiHRLAk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 07:00:40 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 04:00:38 PDT
Received: from iam.tj (soggy.cloud [IPv6:2a01:7e00:e000:151::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F597D64
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 04:00:38 -0700 (PDT)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id A627C340AC
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 11:53:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
        t=1660819982; bh=ZrSVVlmOkdWiMk0ZJZ7tsxKzX99AKnzzaSPx45TUomE=;
        h=Date:To:From:Subject:From;
        b=RtSIt+IwJg42Aukc9/cPZV6BB7/vF9nQoIDGjSOJSDmyPZ8IMqc2fN37HcFBWNRpp
         +Flub8QN82IjqOcmRsSQSGdAbpk2LkoRo5Dgeq1lDYrQRSNUM+PY3m39+YYMfx1v8U
         4UCEVOREUl+cTTh0xJnl27gNCO+Ecg4Hn04dbti6nQMJYEahM2JHCV7seDRleQ5r7U
         8pwq15kdBjMnNY7Vsq9QXtJEBkerCzaRXwBUrsXbGdtJfOHeGOoBf/1xddcT3FwQcx
         iTNp0qnRVdGR10q4l18lR68t1skMKrduRsv+fvGvzdf+8XYh1x5Z1wKlQL9qWOwpkG
         BD73gTTgCqA6Q==
Message-ID: <2e9741aa-562c-cd0d-7ee4-8281512bc2e0@iam.tj>
Date:   Thu, 18 Aug 2022 11:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-GB
To:     linux-efi@vger.kernel.org
From:   Tj <linux@iam.tj>
Subject: ExitBootServices() fails on Samsung W737 (Galaxy Book2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I've been diagnosing a failure to boot on a Samsung Galaxy Book2 (W737) 
but have not been able to get the kernel to boot, and would welcome some 
assistance:

EFI stub: ERROR: Exit boot services failed

The problem occurs in 
drivers/firmware/efi/libstub/efi-stub-helper.c::efi_exit_boot_services(). 
EFI_INVALID_PARAMETER is returned by efi_bs_call(exit_boot_services...).

Based on reading the EDK source I suspected either the key was changing 
or memory alignment is wrong based on a reading of EDK's 
CoreExitBootServices() and CoreTerminateMemoryMap() - making a large 
assumption that Lenovo/Aptio (American Megatrends) firmware is based 
around EDK.

Since the addition of commit d4b341269efb3 "arm64: dts: qcom: Add 
support for Samsung Galaxy Book2" I had inferred it is now possible to 
boot this device into Linux, but so far it seems not.

I added extensive efi_debug() logging to try to identify the problem and 
have reported the patches I'm using and results extensively (too 
extensively for including in this email) at "Issue #11: Samsung Galaxy 
Book2 (SM-W737Y) snapdragon 850" of the aarch64-laptops project:

https://github.com/aarch64-laptops/debian-cdimage/issues/11

The latest results show:

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: DEBUG: Entering allocate_new_fdt_and_exit_boot()
EFI stub: Exiting boot services...
EFI stub: DEBUG: Calling efi_exit_boot_services() with map:
EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870 
map_size=0xa20 desc_size=0x30 desc_ver=0x1
  key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
EFI stub: DEBUG: Entered efi_exit_boot_services()
EFI stub: DEBUG: Memory map before calling priv_func():
EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870 
map_size=0xa20 desc_size=0x30 desc_ver=0x1
  key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
EFI stub: DEBUG: Memory map after calling priv_func():
EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870 
map_size=0xa20 desc_size=0x30 desc_ver=0x1
  key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
EFI stub: DEBUG: Calling efi_bs_call(exit_boot_services, 
0x00000000fcb87c98, 0x2b2c)
EFI stub: DEBUG: efi_bs_call() returned -9223372036854775806 
(EFI_INVALID_PARAMETER)
EFI stub: DEBUG: Calling efi_bs_call() with get_memory_map
EFI stub: DEBUG: Memory map after calling get_memory_map() again:
EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870 
map_size=0xa20 desc_size=0x30 desc_ver=0x1
  key_ptr=0x000000009ffce868 *key_ptr=0x2b6e buff_size=0xc90 }
EFI stub: DEBUG: Calling priv_func() again
EFI stub: DEBUG: Memory map after calling priv_func() again:
EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870 
map_size=0xa20 desc_size=0x30 desc_ver=0x1
  key_ptr=0x000000009ffce868 *key_ptr=0x2b6e buff_size=0xc90 }
EFI stub: DEBUG: Calling (again!) efi_bs_call(exit_boot_services, 
0x00000000fcb87c98, 0x2b6e)
EFI stub: DEBUG: fail: efi_exit_boot_services() returns -9223372036854775806
EFI stub: DEBUG: Returned from efi_Exit_boot_services()
EFI stub: ERROR: Exit boot services failed.
EFI stub: DEBUG: fail_free_new_fdt: status= -9223372036854775806
EFI stub: DEBUG: fail: status= -9223372036854775806
EFI stub: DEBUG: Busy Wait so you can read the debug messages!
