Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35D4EBB9E
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiC3HUw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiC3HUv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 03:20:51 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8F1903E4;
        Wed, 30 Mar 2022 00:19:01 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id DC2BB40A71; Wed, 30 Mar 2022 08:18:59 +0100 (BST)
Date:   Wed, 30 Mar 2022 08:18:59 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux DRTM on UEFI platforms
Message-ID: <20220330071859.GA992@srcf.ucam.org>
References: <20220329174057.GA17778@srcf.ucam.org>
 <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
 <20220330071103.GA809@srcf.ucam.org>
 <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 30, 2022 at 09:12:19AM +0200, Ard Biesheuvel wrote:
> On Wed, 30 Mar 2022 at 09:11, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > The EFI stub carries out a bunch of actions that have meaningful
> > security impact, and that's material that should be measured. Having the
> > secure launch kernel execute the stub without awareness of what it does
> > means it would need to measure the code without measuring the state,
> > while the goal of DRTM solutions is to measure state rather than the
> > code.
> 
> But how is that any different from the early kernel code?

From a conceptual perspective we've thought of the EFI stub as being 
logically part of the bootloader rather than the early kernel, and the 
bootloader is a point where the line is drawn. My guy feeling is that 
jumping into the secure kernel environment before EBS has been called is 
likely to end badly.
