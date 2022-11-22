Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497A0634421
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 19:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiKVS6R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 13:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVS5e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 13:57:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2078CB95;
        Tue, 22 Nov 2022 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=O1MgWVbKEiQxc1NtVXEwlq5tlyYdHJmAX2jcpySlm8I=; b=21hbNGOhxupqlC08N5xsqTqqWT
        y7YJduKNetEpcoBjmSesCIAOitN83qeUo2oqdB0XT6Aq9t54rGY1q1FXviG5hqFVstC0aeBGfcBPj
        wD3S4KRAQv/o0PkDcdHuTXrABb/Kp+2pLJRzihXd68bwN5lGoZ+WkG6QmgrcpgzxL/HOjbCVUI4sz
        pb85XaRJikcn0v9yHXKuKoG+16s6IhfnDfIbBwkR0hYWIKU0J8V0+u/2loxYuXcsO40jc6i4PRlYt
        OsIXgZCpE9CQBb26lyzjIUHqCVP90aa0KmccAca4R0qk+GLxI7hEvCGL3NZJaf2m7cWLSn8zcicb7
        antIW2mg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxYRw-00BR4d-3M; Tue, 22 Nov 2022 18:56:52 +0000
Message-ID: <0cf1d78a-8781-e31e-00a3-3ca68af5a025@infradead.org>
Date:   Tue, 22 Nov 2022 10:56:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 17/17] efi: x86: Make the deprecated EFI handover
 protocol optional
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <20221122161017.2426828-18-ardb@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221122161017.2426828-18-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/22/22 08:10, Ard Biesheuvel wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8c6da5e42d5a6c25..121f1fdca3145fd2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1981,6 +1981,23 @@ config EFI_STUB
>  
>  	  See Documentation/admin-guide/efi-stub.rst for more information.
>  
> +config EFI_HANDOVER_PROTOCOL
> +	bool "EFI handover protocol (DEPRECATED)"
> +	depends on EFI_STUB
> +	default y
> +	help
> +	  Select this in order to include support for the deprecated EFI
> +	  handover protocol, which defines alternative entry points into the
> +	  EFI stub.  This is a practice that has no basis in the UEFI
> +	  specification, and requires a priori knowledge on the part of the
> +	  bootloader about Linux/x86 specific ways of passing the command line
> +	  and initrd, and where in memory those assets may be loaded.
> +
> +	  If in doubt, say Y. Even though he corresponding support is not

	                                  the

> +	  present in upstream GRUB or other bootloaders, most distros build
> +	  GRUB with numerous downstream patches applied, and may rely on the
> +	  handover protocol as as result.

-- 
~Randy
