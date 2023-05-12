Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88692700685
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbjELLTC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjELLTB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 07:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AF810CC;
        Fri, 12 May 2023 04:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0338B60C86;
        Fri, 12 May 2023 11:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597F7C433AF;
        Fri, 12 May 2023 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683890339;
        bh=wrH/Idv9KsCcTtB6AEiMG8KI/BJCz1nJH6Vnh8hMzRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V6trYjUgtstm5dpjpCYea1rOSnD3aeOkI2RIw1qK6pV/lewPI0AnCrW06WfEqtYZc
         9LAet3VMOMlI1GUsKtOBxhIQuyEbhuuYQWK/W6xIty4E//fwvjkAYImTcfzv1MnIGu
         OuVZRxah59hU0gqRMOO92eykexszq5MWG/sc4pHOKaAYEuGcsZrvIodbVRFYbOmNYf
         qQ4Qd8vUIhS4EBbe5XZ4t5sYL3WaJfjtlIhO8NDqkl+VzT6jUEZJPJGSGhER/SVICI
         JNeyMKkgT6TSfJZ3jPMK456k7HYTPNQ9ToeeqTWRe11aYNXPjJLGaBL3mBjcj2RpCs
         Ekx6B8fn/ovLA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f2676d62a2so2905524e87.0;
        Fri, 12 May 2023 04:18:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDwM9h4S+3/pwLf5oDdFTQ7W446eJYm19aiNFeLzBiF9PPtaYKov
        2QVCKYLjK3PrE78nuld2D3df7/fh9sAqpECB3hc=
X-Google-Smtp-Source: ACHHUZ6DcMj03Yf/WFptKjdSvGMbYyaFXfuBq2GVQwGFgSoSXnv8faAMu33gdmWGPUcUBML9YF2JhMMaXS1ogxTh7As=
X-Received: by 2002:ac2:5de4:0:b0:4db:1bab:98a4 with SMTP id
 z4-20020ac25de4000000b004db1bab98a4mr3828248lfq.32.1683890337217; Fri, 12 May
 2023 04:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com> <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
In-Reply-To: <20230512110455.GD14461@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 May 2023 13:18:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
Message-ID: <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
>
> > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> > now?
>
> TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
> at the whim of the firmware in terms of whether the SHA-2 banks are
> enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
> extending the SHA-1 banks, a malicious actor can later turn up and
> extend whatever they want into them and present a SHA-1-only
> attestation. Ideally whatever is handling that attestation should know
> whether or not to expect an attestation with SHA-2, but the easiest way
> to maintain security is to always extend all banks.
>

Wouldn't it make more sense to measure some terminating event into the
SHA-1 banks instead?
