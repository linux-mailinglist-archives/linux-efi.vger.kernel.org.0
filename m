Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83B635AA9
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKWK5T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 05:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiKWK5B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 05:57:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C86F242D;
        Wed, 23 Nov 2022 02:49:46 -0800 (PST)
Received: from zn.tnic (p200300ea9733e747329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e747:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B2CC1EC064F;
        Wed, 23 Nov 2022 11:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669200585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BFjGMXlHg3TcPz+34w140e1Tv0t0lXT0KaNS3z4Fp7E=;
        b=P1omuEOFaA26NgokeFL5RB0ox+F6eVVDNOjA/cn4S1eYh+2O8Bbh+Y7WM6mKkqwnAJ3mjl
        Tiy0BNOhS3Xgu40yD6EmWHUOQonbzLVnh7+g7JFpS9wNrq50VB9/yJaEg848zcrnROWJkY
        FDMJJ3wiVyfauxwjiQj0yVWw+xm1+bw=
Date:   Wed, 23 Nov 2022 11:49:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Message-ID: <Y336yE4P3NjCGavN@zn.tnic>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 22, 2022 at 03:49:29PM -0600, Tom Lendacky wrote:
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index cb5f0befee57..a0bfd31358ba 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -23,7 +23,7 @@
>  const efi_system_table_t *efi_system_table;
>  const efi_dxe_services_table_t *efi_dxe_table;
> -u32 image_offset;
> +u32 image_offset __section(".data");
>  static efi_loaded_image_t *image = NULL;
>  static efi_status_t
> 
> I assume it has to do with being in .data vs .bss and not being explicitly
> cleared with the encryption bit set. With the change to put image_offset in
> the .data section, it is read as zero, where as when it was in the .bss
> section it was reading "ciphertext".

Hmm, two points about this:

1. Can we do

u32 image_offset __bss_decrypted;

here instead? We have this special section just for that fun and it
self-documents this way.

2. Also, why does my SEV-ES guest boot just fine without that change?

[    0.000000] Linux version 6.1.0-rc6+ (root@ml) (gcc (Debian 11.3.0-1) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT_DYNAMIC Wed Nov 23 11:27:17 CET 2022
...
[    0.336132] Memory Encryption Features active: AMD SEV SEV-ES

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
