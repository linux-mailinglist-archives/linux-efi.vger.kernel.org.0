Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2B623CD6
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 08:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKJHm3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 02:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKJHm1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 02:42:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD4229;
        Wed,  9 Nov 2022 23:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48B4D61DA2;
        Thu, 10 Nov 2022 07:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF43C43147;
        Thu, 10 Nov 2022 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668066142;
        bh=vGnlMB/2HOSpO2YQlw0qSWBFXOh59PeBdgpXlTbb4xg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wr/cwLZ629WQhtGweevX8mjPjjI9Ms1KRhD7KD6dGOgUE09XcA6SrLmP/uxmiIAwE
         ilJsfBXIP8hBMD17pIz5/sCnYybiiXXfzXJ8ODxpkfJAn1YAhADHCfP2fzaSqUKzaL
         iGJ+utbEFY6BMVlY85su+GoOSvlfZtcnZP9MZdmGMusLSPsIsoNZF5DtCVVZIwDA5w
         DNqMzMPjOTcN9az0wJXuDswi1KOJOOUt6XecXcmdunrdZuPYhgtFEyCk1+1HX4uPaS
         ZLOFWgPKeNh1v1jtyKdFVRW8u7dxesOip82rb4hB7HG7+WcLslYAvrwm2jvfqfViNH
         52D49iYcOpT5A==
Received: by mail-lj1-f172.google.com with SMTP id k19so582776lji.2;
        Wed, 09 Nov 2022 23:42:22 -0800 (PST)
X-Gm-Message-State: ACrzQf0m/n9bHRX3RaEx7kxoSXmOVYGuIXRs1rqoE8J9Iv9KGAlmfuMG
        eN02ZLQDsVTvei4C5xQIUrjto5hCLFjFkxy2a+I=
X-Google-Smtp-Source: AMsMyM5CTnFUd6qm6+4S2vOZEcs8fjls4hVzitvR3CFeGIaQs/QemaR60+RGraj6GpRs4rBOZZOZ7W/WL+ot9XbUZys=
X-Received: by 2002:a05:651c:c6:b0:277:96a:5c32 with SMTP id
 6-20020a05651c00c600b00277096a5c32mr8067111ljr.415.1668066140429; Wed, 09 Nov
 2022 23:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-17-eric.snowberg@oracle.com> <20221110000129.kl6pjy5mafpuptbk@framework>
In-Reply-To: <20221110000129.kl6pjy5mafpuptbk@framework>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Nov 2022 08:42:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHcf_QptjHfFJxkUQrv=Lfg5=pkt2UTOZ5F-pffki-=-Q@mail.gmail.com>
Message-ID: <CAMj1kXHcf_QptjHfFJxkUQrv=Lfg5=pkt2UTOZ5F-pffki-=-Q@mail.gmail.com>
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT found
To:     Morten Linderud <morten@linderud.pw>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Nov 2022 at 01:01, Morten Linderud <morten@linderud.pw> wrote:
>
> On Tue, Nov 23, 2021 at 11:41:23PM -0500, Eric Snowberg wrote:
> > A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
> > introduced in shim. When this UEFI variable is set, it indicates the
> > end-user has made the decision themselves that they wish to trust MOK keys
> > within the Linux trust boundary.  It is not an error if this variable
> > does not exist. If it does not exist, the MOK keys should not be trusted
> > within the kernel.
>
> Hi Eric,
>
> I've been milling around on this patch-set for a while and I have a few issues
> with the description of the commit and what the code actually does.
>
> efi_mokvar_entry_find doesn't simply read an UEFI variable as the commit message
> suggests, it will look for the MOK variable loaded into the EFI configuration
> table. This implies we need this table setup in early boot to take usage of this
> patch set.
>
> The only bootloader that does setup this table, is the `shim` as described. But
> no other bootloader implements support for the MOK EFI configuration table.
>

Does any other bootloader implement support for the (volatile)
MokListTrustedRT variable?

Note that this variable is intentionally volatile, and should be
rejected by the kernel if it is not. The point of these RT variables
or the config tables is that they can only be set at boot if a signed
and therefore trusted agent created them.

Permitting non-volatile variables here defeats the purpose of secure
boot, which aims to prevent exploits from gaining persistence. It
would be bad if you could corrupt the trusted boot chain forever by
setting a variable once.

> This effectively means that there is still no way for Machine Owners to load
> keys into the keyring, for things like module signing, without the shim present
> in the bootchain. I find this a bit weird.
>
> Is this an intentional design decision, or could other ways be supported as
> well?
>

Yes.

If we are looking for a way to use EFI variables to inject additional
certificates into the keyring without the ability to authenticate
them, we should I'd strongly recommend that we disable that by default
and add a big fat warning that it is incompatible with the guarantees
secure boot aims to provide.
