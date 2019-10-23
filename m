Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C55E24B8
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391546AbfJWUpX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 16:45:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44569 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732293AbfJWUpX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Oct 2019 16:45:23 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.42])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x9NKiVNI654501
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 23 Oct 2019 13:44:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x9NKiVNI654501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1571863478;
        bh=IxSw0En77HLXWyxMsAZA8B4xJrdNJCgIFWutGFFmmRQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ai7tp2yA8yPU8FUEgNh/Hfr47IbCe0eyYCGmwSZaS5Rws5CAHWcVBinf/nbkpnATG
         AOHwxFokRgB8ciGOBP1AxRsKa7oqSkUtLXN3uSAoEVPRwFU67/ZU1jVGt7j5UlXzE+
         wLtLdmNJ5kMKcGxlWrBiXZ8UEr9h51Sva8epb8OghyHlTTFau9/NMCr2KV4qJy85LE
         18NxuEXX8QnmAOuAn4kc6WVSszp+BfNNZdKtum03l40w/MnLX3P8nZ9UYBmSx2ef0C
         9xhqS4HYTFyV7vJ9gTVsFY6Sg/efL3IRRwCmsMWTVohZow0ckxThLCMouh0DPe8VAh
         Dky+SXXXWz3Yg==
Subject: Re: [PATCH v3 0/3] x86/boot: Introduce the kernel_info et consortes
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        jgross@suse.com, konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de,
        Randy Dunlap <rdunlap@infradead.org>
References: <20191009105358.32256-1-daniel.kiper@oracle.com>
 <20191016110642.5q3bm73vi6o6gn5r@tomti.i.net-space.pl>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <781feb2e-a4e1-36f8-ba01-a3c6101f5193@zytor.com>
Date:   Wed, 23 Oct 2019 13:44:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016110642.5q3bm73vi6o6gn5r@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2019-10-16 04:06, Daniel Kiper wrote:
> On Wed, Oct 09, 2019 at 12:53:55PM +0200, Daniel Kiper wrote:
>> Hi,
>>
>> Due to very limited space in the setup_header this patch series introduces new
>> kernel_info struct which will be used to convey information from the kernel to
>> the bootloader. This way the boot protocol can be extended regardless of the
>> setup_header limitations. Additionally, the patch series introduces some
>> convenience features like the setup_indirect struct and the
>> kernel_info.setup_type_max field.
>>
>> Daniel
>>
>>  Documentation/x86/boot.rst             | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  arch/x86/boot/Makefile                 |   2 +-
>>  arch/x86/boot/compressed/Makefile      |   4 +-
>>  arch/x86/boot/compressed/kaslr.c       |  12 ++++++
>>  arch/x86/boot/compressed/kernel_info.S |  22 +++++++++++
>>  arch/x86/boot/header.S                 |   3 +-
>>  arch/x86/boot/tools/build.c            |   5 +++
>>  arch/x86/include/uapi/asm/bootparam.h  |  16 +++++++-
>>  arch/x86/kernel/e820.c                 |  11 ++++++
>>  arch/x86/kernel/kdebugfs.c             |  20 ++++++++--
>>  arch/x86/kernel/ksysfs.c               |  30 ++++++++++----
>>  arch/x86/kernel/setup.c                |   4 ++
>>  arch/x86/mm/ioremap.c                  |  11 ++++++
>>  13 files changed, 292 insertions(+), 16 deletions(-)
>>
>> Daniel Kiper (3):
>>       x86/boot: Introduce the kernel_info
>>       x86/boot: Introduce the kernel_info.setup_type_max
>>       x86/boot: Introduce the setup_indirect
> 
> hpa, ping?
> 

Looks really good to me, modulo the feedback Randy already brought up.

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

	-hpa

