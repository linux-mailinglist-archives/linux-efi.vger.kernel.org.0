Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40F4624439
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 15:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiKJO2M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 09:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiKJO15 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 09:27:57 -0500
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41E2B1B2;
        Thu, 10 Nov 2022 06:27:54 -0800 (PST)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id A6D40C02F9;
        Thu, 10 Nov 2022 15:27:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1668090441;
        bh=MhKGVo+uz4V4OaO6LB9aTH5ZhyCzEMz1L4b8NypmKFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pV7ZJs0wm6DoWbNjgQ+nre7AcLTDY9WVWraufktJu96LBq13zg+ORlj3eqac5P/jj
         sMBlqx/H+vSyu4f9+/6sHDLHph7DIUisaViFST30qXOl37wOXwCbDWED1LfSVsN/Vj
         fb3H/3D66XcvNAUJsXfEwbshrIio2ghp4UTkkF93hmuDYCqMBuhHI2yX8y9HPFUr47
         9zoL+nAgNNl6cl4DE4UmXiR6JOsAciTVQIIj7CAXmJ2nUiNJRkHecOeeRHzzDLoMwc
         eNYUzMBTy2ARfxxxEE1EmCXQCkjSH2zc68qZMwAn+/FxVFgQL0VFvAQitaHQ9JX3pR
         oQQNY2tETyKeBoelslPOTZLwOsdRieO4fHXa5+xGMISfpMNnZdATUHfKtZWyRg3Jzv
         8nwalYgLEzzoFg63OXIBgRXCa+NnRYAFg/8cBefxKTC6j5V1RAVCkd9lM6MTAPBA5z
         C7CKZ/KqI12S8QMsTMkpiY7XvRcz+QfjQ//48NsSx1285pURq2enhfZB/qkkSB7Bfr
         +QJXFonan9vGffFSrKM44TdAQQJ77s1oisLUJbqpyEBOVZwtZLX8siu3MF5Tpe4kqC
         4tWOuNyJvVh2sVF4+oxM7FYePuyEkyfBN0qP0b6vhD9x6ib/ibVB2R5iEPEOXe2cdJ
         SXdVZurOzBsJhlsvBextfyis=
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 6DC1DC028C;
        Thu, 10 Nov 2022 15:27:21 +0100 (CET)
Date:   Thu, 10 Nov 2022 15:27:19 +0100
From:   Morten Linderud <morten@linderud.pw>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
Message-ID: <20221110142719.k2dhn2ytucsn3wfr@framework>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com>
 <20221110000129.kl6pjy5mafpuptbk@framework>
 <CAMj1kXHcf_QptjHfFJxkUQrv=Lfg5=pkt2UTOZ5F-pffki-=-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHcf_QptjHfFJxkUQrv=Lfg5=pkt2UTOZ5F-pffki-=-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 10, 2022 at 08:42:08AM +0100, Ard Biesheuvel wrote:
> On Thu, 10 Nov 2022 at 01:01, Morten Linderud <morten@linderud.pw> wrote:
> >
> > On Tue, Nov 23, 2021 at 11:41:23PM -0500, Eric Snowberg wrote:
> > > A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
> > > introduced in shim. When this UEFI variable is set, it indicates the
> > > end-user has made the decision themselves that they wish to trust MOK keys
> > > within the Linux trust boundary.  It is not an error if this variable
> > > does not exist. If it does not exist, the MOK keys should not be trusted
> > > within the kernel.
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
> 
> Does any other bootloader implement support for the (volatile)
> MokListTrustedRT variable?
> 

No. The efforts seems to be mostly focused on supporting a setup where shim
boots grub. Anything besides this has never really been important for the people
writing it.

The main reason for the email is to try and figure out what the EFI
configuration table adds to the threat model.

> Note that this variable is intentionally volatile, and should be
> rejected by the kernel if it is not. The point of these RT variables
> or the config tables is that they can only be set at boot if a signed
> and therefore trusted agent created them.

So the only trusted agent currently is the shim? It claims to be a "trivial EFI
application" but the interplay between mokutils and shim isn't documented and
not trivial to understand.

> Permitting non-volatile variables here defeats the purpose of secure
> boot, which aims to prevent exploits from gaining persistence. It
> would be bad if you could corrupt the trusted boot chain forever by
> setting a variable once.

Would this change if the variable could be read from the EFI configuration table
or as an EFI variable? Instead of the current situation where we only support
the configuration table?

> > This effectively means that there is still no way for Machine Owners to load
> > keys into the keyring, for things like module signing, without the shim present
> > in the bootchain. I find this a bit weird.
> >
> > Is this an intentional design decision, or could other ways be supported as
> > well?
> >
> 
> Yes.

I assume it's a yes to "intentional design decision", and my followup question
to this would be to ask where it's documented?

> If we are looking for a way to use EFI variables to inject additional
> certificates into the keyring without the ability to authenticate
> them, we should I'd strongly recommend that we disable that by default
> and add a big fat warning that it is incompatible with the guarantees
> secure boot aims to provide.

The present features are all disabled by default I believe?

Most of this seems to be knowledge residing between a few people that was
present at the implementation, and as a user-space tool author comming into this
10 years later, it's really hard to figure out how a lot of these decisions came
to be.

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
