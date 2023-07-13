Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817D5752437
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGMNwo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGMNwo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 09:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751DB1992;
        Thu, 13 Jul 2023 06:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF7F6103B;
        Thu, 13 Jul 2023 13:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A026C433C8;
        Thu, 13 Jul 2023 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256362;
        bh=Z+wdPp4bBuT9L1ChT+AHlpXverdOI7n2EbrlbDUz34A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZOiOP3YZFmh51YhkcCfOxZrjGErPWqe3Xpl4tiS3X+tTndYWqhMu/6gjuvoHMwPS
         zhAe+a7EQIbGsdRYnPkwkIf0MZOW4P3wV5ubOhXagF083YdxDAuIaJqyQT+7oiEb3E
         9kOAtYxAHujbx77HMQBk7+3tRCM/+jYsgzztobYBdzF4pk8gi3nJsBsqlBs0BmXxNV
         RH4N1P5k8E6qDoCoQUGYcz2euZx5FQxveJ+rt0G3Pm6EwILfhucj3grOP/d1y+HZHw
         djfTWa/6EDiJF+YhV9j+4mbOr5stgOI0dZMh/qFkJ155FEa0kCw5RJdDagGWz67tjQ
         hiNvxuWfL9N3A==
Date:   Thu, 13 Jul 2023 15:52:35 +0200
From:   Ard Biesheuvel <ardb@kernel.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        ardb@kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <ZLABozIRVGmwuIBf@gambale.home>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/9MlTh435FP5Ji@gambale.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(add linux-efi@ cc)

On Thu, Jul 13, 2023 at 03:33:38PM +0200, Ard Biesheuvel wrote:
> Hello Emanuele,
> 
> Please cc the linux-efi@ mailing list and myself on EFI related patches.
> 
> First of all, I think the tone of the discussion is way out of hand on
> both sides of the debate. Please keep it civil and courteous.
> 
> On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> > *Important*: this is just an RFC, as I am not expert in this area and
> > I don't know what's the best way to achieve this.
> > 
> > v2:
> > * add standard "sbat,1,SBAT Version,..." header string
> > 
> > The aim of this patch is to add a .sbat section to the linux binary
> > (https://github.com/rhboot/shim/blob/main/SBAT.md).
> > We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> > to revoke authorizations to specific signed PEs that were initially
> > considered as trusted. The reason might be for example a security issue
> > related to a specific linux release.
> > 
> > A .sbat is simply a section containing a string with the component name
> > and a version number. This version number is compared with the value in
> > OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> > even if it is correctly signed.
> > 
> 
> Most people will not known what OVMF_VARS is or a PE.
> 
> Also, 'version number' is a bit vague, better to stick with existing
> terminology that makes this more self explanatory: the component that
> authenticates the kernel image keeps a revocation counter, and refuses
> to load authentic images whose revocation index is lower than the
> revocation counter. This approach removes the need for revoking
> individual image hashes or having to rotate the signing keys when a
> vulnerability is discovered.
> 
> The argument that we need this in the upstream kernel seems to be
> predicated on the assumption that there is one universal signing
> authority and revocation domain, but this is not necessarily true. Even
> if the distros appear to have decided that it is a reasonable choice to
> deploy the MicroSoft signed shim and the associated components on other
> systems than Windows-crippled x86 PCs, this is not universally true, and
> UEFI secure boot can be (and is) deployed in sane ways as well.
> 

Note that by Windows-crippled, I mean x86 PCs built by OEMs who care
about nothing other than the Windows logo sticker. These PCs often don't
allow secure boot keys to be modified by the owner of the machine, or
secure boot to be disabled at all. This is why shim exists, not because
UEFI secure boot is broken by design.

