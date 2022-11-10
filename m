Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25A624409
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiKJOPu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 09:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiKJOPa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 09:15:30 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB5FCF6;
        Thu, 10 Nov 2022 06:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668089715;
        bh=D33KMzIP9yA3igQjnTMcoISaaUHsENaYABMb+FA7qD4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xScjO22r/xKYFmHS+B9druEMUYnF4vE5eOS8iXkQ0nfwP2CHw0kiWiZ4X0pL+eJHG
         +xy9SnhGWE756tr6+R3wPxoQ0goSI2KZL4mtjPMPbSOYjXstVZ2+nVwP5qE30qcXvz
         5HaJysRg1ucgOeKsMFtWZfn+FKG6vKClIR3mCXHU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4AB081285E75;
        Thu, 10 Nov 2022 09:15:15 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NHAnOhPP-o7i; Thu, 10 Nov 2022 09:15:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668089715;
        bh=D33KMzIP9yA3igQjnTMcoISaaUHsENaYABMb+FA7qD4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xScjO22r/xKYFmHS+B9druEMUYnF4vE5eOS8iXkQ0nfwP2CHw0kiWiZ4X0pL+eJHG
         +xy9SnhGWE756tr6+R3wPxoQ0goSI2KZL4mtjPMPbSOYjXstVZ2+nVwP5qE30qcXvz
         5HaJysRg1ucgOeKsMFtWZfn+FKG6vKClIR3mCXHU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DA541128198C;
        Thu, 10 Nov 2022 09:15:12 -0500 (EST)
Message-ID: <a7c6fb4802f73bee4466f055a8b44ea7881094ef.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Morten Linderud <morten@linderud.pw>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 10 Nov 2022 09:15:11 -0500
In-Reply-To: <20221110000129.kl6pjy5mafpuptbk@framework>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-17-eric.snowberg@oracle.com>
         <20221110000129.kl6pjy5mafpuptbk@framework>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2022-11-10 at 01:01 +0100, Morten Linderud wrote:
[...]
> efi_mokvar_entry_find doesn't simply read an UEFI variable as the
> commit message suggests, it will look for the MOK variable loaded
> into the EFI configuration table. This implies we need this table
> setup in early boot to take usage of this patch set.
> 
> The only bootloader that does setup this table, is the `shim` as
> described. But no other bootloader implements support for the MOK EFI
> configuration table.

Just to be precise: shim isn't a boot loader.  It's a trust pivot
device away from the built in UEFI keys to the Machine Owner Keys. 
Shim is designed to be used with another bootloader like grub or sd-
boot.  Now you could load a kernel directly with shim, in the same way
you could load it directly from UEFI, but that doesn't make it a
bootloader.

> 
> This effectively means that there is still no way for Machine Owners
> to load keys into the keyring, for things like module signing,
> without the shim present in the bootchain. I find this a bit weird.
> 
> Is this an intentional design decision, or could other ways be
> supported as well?

Yes, rather than try to have all bootloaders conform to the MoK
protocol, it's easier to implement it in a single purpose component
that can be used with any of them.  Essentially if you want to rely on
the UEFI keys and not do an MoK pivot (as some people do) then you can
remove shim from the sequence.

In many ways that's part of the problem with this patch set: The
underlying assumption is everyone does this trust pivot.  If you don't
do this trust pivot (I don't for instance, having replaced my UEFI keys
with my own) you can't add keys to the kernel this way.  However, how
would the kernel know whether you trust the UEFI keys or not?  The
other problem is that without the shim protocol being present, grub
can't check the kernel signature, which means that even if you do own
your own UEFI keys, you need something to replace shim, like:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/efitools.git/tree/ShimReplace.c

James

