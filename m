Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5706FE730
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjEJW2o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 18:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjEJW2m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 18:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB7270D;
        Wed, 10 May 2023 15:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44F0C630E2;
        Wed, 10 May 2023 22:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5981C433D2;
        Wed, 10 May 2023 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683757719;
        bh=1W4Tchoh84C5QWw5XU02NZ4Hk4wBRIADDe2kWbFhDbg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=MQrjtZE7rCyCxkaAjSFd9e5OPXIDJEZf7inGknMgUfolDQrdak7030W6sVj5Y+jvh
         nPs/M8QHCh9gftNAXVp8cbWVnTADGxNjM/qWFGfQLuX2l9ZRJCGcYCocyyS4X5BD1a
         enq0ve6NoQ41pHnmbnj6UWom4F7KY73uvhyriHRj/PGVQAl3D72FwRg7kBmj05J2+G
         bYzK7oiMwvRtx3IzUpmwvyum0I8f30YOVAqVifHUixcVQj/yDZjnBH7v/QlJmf3MIb
         F+2QBE5p/KMfgZOML7a9i627jSqnm9E1FHpLjDBUZ8pxrnKRdT1uad9C0RWk0QehBe
         VjDvU+SMF1sfw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:28:33 +0300
Message-Id: <CSIYAN7SXASE.34Z0FBRCENLAI@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
        <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
        <James.Bottomley@hansenpartnership.com>, <luto@amacapital.net>,
        <nivedita@alum.mit.edu>, <kanth.ghatraju@oracle.com>,
        <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Biggers" <ebiggers@kernel.org>,
        "Ross Philipson" <ross.philipson@oracle.com>
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
In-Reply-To: <20230510012144.GA1851@quark.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed May 10, 2023 at 4:21 AM EEST, Eric Biggers wrote:
> On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
> > From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >=20
> > The SHA algorithms are necessary to measure configuration information i=
nto
> > the TPM as early as possible before using the values. This implementati=
on
> > uses the established approach of #including the SHA libraries directly =
in
> > the code since the compressed kernel is not uncompressed at this point.
> >=20
> > The SHA code here has its origins in the code from the main kernel:
> >=20
> > commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> >=20
> > That code could not be pulled directly into the setup portion of the
> > compressed kernel because of other dependencies it pulls in. The result
> > is this is a modified copy of that code that still leverages the core
> > SHA algorithms.
> >=20
> > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>
> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SH=
A-2
> now?
>
> And if you absolutely MUST use SHA-1 despite it being insecure, please at=
 least
> don't obfuscate it by calling it simply "SHA".

AFAIK the TCG specs require for any TPM2 implementation to support both
SHA-1 and SHA-256, so this as a new feature should lock in to the
latter.

BR, Jarkko
