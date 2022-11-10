Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F6624514
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiKJPGt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 10:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKJPGs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 10:06:48 -0500
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED97654A;
        Thu, 10 Nov 2022 07:06:45 -0800 (PST)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id B5DA3C015B;
        Thu, 10 Nov 2022 16:06:09 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1668092769;
        bh=I1b2dWCqEXwMKJH2vHZvQa6XE/PkoH+lyJ1N5u9y6FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=I4DQ05EXSWOhXclVgNBGO3WdLuLlRIgU7bBuzF2VrGd/gVA23cjXotKnUlCP8J4db
         NSNHzOFSk0hjV/i0PN+VcdwFQ5XE0oirGaIcCHUxEtDosx3yicVQuw1+mIQ4LpjEMN
         jfRUWLDQvSLej7JqybvsZAKFteMrsMLQDr/byy+zVHoM97zz/yMKGorcckPrDaql8f
         CzUrl/+4NurAKiUjX+Ipk1H/hHAZlDMR0JwfNY12Z5JYvWEUusSB5SKnAWhiE7yfld
         +CRIzFfWkQCMVEbJl6GQto7umB+B8T96tHrN/Ot7ZCuxsKJl/pTjrMRxTBtqgj+Zu7
         qejWy9NFDZ7ct/9w+ivn4VhOPyTPu9jfH9xInfSHcupq7ckuYaxvmw372pj7ZthRPG
         ktBxZEQzfTelTEYX52nNPIKHQDBjmlbOS7+5lcQdOemz0XHa6r84EgBix/vVJ/QsP7
         oSvKgGG5E6a/uK9uXqWYMzLFHvQ+SNkFVehBQ0bnVZjuW8MvnOfKIyHKCCDvbjvmdA
         SUW66V/QZGlxwdAGAonb9Fbh3uwZT4gcq/bLvShJLgNnk/OI+XinP2KLWwG+3il7BM
         0mLF8KHU1l+zdUnB9dt5ydpALA7MaQF92McRKlh6sfYFbIQF5Eq/6bHdXPi42gw7dP
         VVly4Wm2Y7u0E5U788Tnad3I=
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 7AF8AC0077;
        Thu, 10 Nov 2022 16:06:09 +0100 (CET)
Date:   Thu, 10 Nov 2022 16:06:07 +0100
From:   Morten Linderud <morten@linderud.pw>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
Message-ID: <20221110150607.h4iaymkgc4f7kuue@framework>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com>
 <20221110000129.kl6pjy5mafpuptbk@framework>
 <4A479B96-4B41-4323-9920-5A909423F998@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A479B96-4B41-4323-9920-5A909423F998@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 10, 2022 at 12:54:43AM +0000, Eric Snowberg wrote:
> 
> 
> > On Nov 9, 2022, at 5:01 PM, Morten Linderud <morten@linderud.pw> wrote:
> > 
> > On Tue, Nov 23, 2021 at 11:41:23PM -0500, Eric Snowberg wrote:
> >> A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
> >> introduced in shim. When this UEFI variable is set, it indicates the
> >> end-user has made the decision themselves that they wish to trust MOK keys
> >> within the Linux trust boundary.  It is not an error if this variable
> >> does not exist. If it does not exist, the MOK keys should not be trusted
> >> within the kernel.
> > 
> > Hi Eric,
> > 
> > I've been milling around on this patch-set for a while and I have a few issues
> > with the description of the commit and what the code actually does.
> > 
> > efi_mokvar_entry_find doesn't simply read an UEFI variable as the commit message
> > suggests, it will look for the MOK variable loaded into the EFI configuration
> > table. This implies we need this table setup in early boot to take usage of this
> > patch set.
> > 
> > The only bootloader that does setup this table, is the `shim` as described. But
> > no other bootloader implements support for the MOK EFI configuration table.
> > 
> > This effectively means that there is still no way for Machine Owners to load
> > keys into the keyring, for things like module signing, without the shim present
> > in the bootchain. I find this a bit weird.
> > 
> > Is this an intentional design decision, or could other ways be supported as
> > well?
> 
> In v6 I had it as a RT variable, during the review a request was made [1] to just 
> use the EFI configuration table.  If there are other boot loaders that want to use this,
> I don’t see why the code in v6 couldn’t be added back.  If the configuration table isn’t
> available, it could try reading the RT var next.
> 
> 1. https://patchwork.kernel.org/project/linux-integrity/patch/20210914211416.34096-13-eric.snowberg@oracle.com/#24453409
> 

If we could support both the EFI variables and the EFI configuration table setup
it would hopefully be easier for others to implement the interface? I wouldn't
mind trying to write a patch for that if others think it's a good idea.

I'm not really sure what Peter means with "much more reliable" though.

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
