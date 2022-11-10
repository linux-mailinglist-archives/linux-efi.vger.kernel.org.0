Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D001D623875
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 01:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKJA4m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 19:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiKJA4k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 19:56:40 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 16:56:39 PST
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE61620F56;
        Wed,  9 Nov 2022 16:56:39 -0800 (PST)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 0E360C0273;
        Thu, 10 Nov 2022 01:01:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1668038494;
        bh=jH0zJFbDnCevPE8tf0c1v6aSJKKT3slV14YINE41imY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=U0dBESQLYHV9bR+lJN7IIwR0s+9MLgjZCaC29vtuBJicKAlUqCJA/8h/XDWPRT+aF
         5KGr3uiWk0XJtRScrl5QEjn+4vrjGQX6Hms9RmxW4AkcL2KhEOKVdDq0uW6cgGQONK
         2b4cV4OyG6EX7fiuO9KVbz5Z4vzANcy+Y620PKtCpjpG1K7OO9h5XZTbxi9L0PMK+Q
         aUS3852wWwcdISxeTKf1y2Ml8l0fUnlcnQV/LArMUSwZMAhyQYLFxrMvag93Kiyk+o
         rgXzF2R5k8lckO/HVRNen26BJvRNU0SC5YMhd0auAvTQ6dQqce+Sz+TrJdEGUNP5gP
         uhuBd0M6nP3FPkxnbFRv78o5outAF7pLYBRXxWTRO6i0k9TRWsmacCM6mG6aY36vI1
         2KniNKKH4W78ldDkHY+gCKUyawFiWTBFaR3XVqCWJVZcQZinjjR9H33JyfBQk0qXIO
         0N/PymYd9tifdimGEspYZGfkGsfEaGAm3dMD+ZAbK+0eEgGQJvePRoTE/CC2NAH222
         0UiUBrTyfQVCWSV8PQedyGwLX/QEh9x98BnJnlUCqIPu7J57W2tWzWVuAirp1EdPec
         EK5Ht57VCNavVXl5d41jZLG7OXYo5osfeImVkvEoryGIuy8lObCOhlYTJNX4Kmi0r2
         FdQA/J5zBQKLrm8VZGwq9hMs=
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id BFB40C007F;
        Thu, 10 Nov 2022 01:01:34 +0100 (CET)
Date:   Thu, 10 Nov 2022 01:01:29 +0100
From:   Morten Linderud <morten@linderud.pw>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
Message-ID: <20221110000129.kl6pjy5mafpuptbk@framework>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124044124.998170-17-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 23, 2021 at 11:41:23PM -0500, Eric Snowberg wrote:
> A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
> introduced in shim. When this UEFI variable is set, it indicates the
> end-user has made the decision themselves that they wish to trust MOK keys
> within the Linux trust boundary.  It is not an error if this variable
> does not exist. If it does not exist, the MOK keys should not be trusted
> within the kernel.

Hi Eric,

I've been milling around on this patch-set for a while and I have a few issues
with the description of the commit and what the code actually does.

efi_mokvar_entry_find doesn't simply read an UEFI variable as the commit message
suggests, it will look for the MOK variable loaded into the EFI configuration
table. This implies we need this table setup in early boot to take usage of this
patch set.

The only bootloader that does setup this table, is the `shim` as described. But
no other bootloader implements support for the MOK EFI configuration table.

This effectively means that there is still no way for Machine Owners to load
keys into the keyring, for things like module signing, without the shim present
in the bootchain. I find this a bit weird.

Is this an intentional design decision, or could other ways be supported as
well?

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
