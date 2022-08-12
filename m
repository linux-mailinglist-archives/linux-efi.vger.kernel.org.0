Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E9590B9C
	for <lists+linux-efi@lfdr.de>; Fri, 12 Aug 2022 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiHLFyn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Aug 2022 01:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLFym (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 Aug 2022 01:54:42 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90959A222B;
        Thu, 11 Aug 2022 22:54:38 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 168AC40A77; Fri, 12 Aug 2022 06:54:37 +0100 (BST)
Date:   Fri, 12 Aug 2022 06:54:37 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Brendan Trotter <btrotter@gmail.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: Re: Linux DRTM on UEFI platforms
Message-ID: <20220812055437.GA10952@srcf.ucam.org>
References: <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
 <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
 <CAELHeEe5H8BNf8K22XRm3hXf=_imHBnf-MHcFYvPCXX7GYkt4w@mail.gmail.com>
 <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
 <CAELHeEe2CiTXfMf3OYu3bzc_kH=rs4qzC-4XQL12AM=Nq8Csjw@mail.gmail.com>
 <20220810174638.GA7906@srcf.ucam.org>
 <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
 <20220811182502.GA32433@srcf.ucam.org>
 <CAELHeEcfHSXewFCywsYeN_g8Q_BNG+4tP-QENO5QBw8Dj91yMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELHeEcfHSXewFCywsYeN_g8Q_BNG+4tP-QENO5QBw8Dj91yMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 12, 2022 at 12:52:58PM +0930, Brendan Trotter wrote:
> Hi,
> 
> On Fri, Aug 12, 2022 at 3:55 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Thu, Aug 11, 2022 at 07:25:58PM +0930, Brendan Trotter wrote:
> > > On Thu, Aug 11, 2022 at 3:16 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > > The kernel has no way to know this - *any* code you've run before
> > > > performing a measurement could tamper with the kernel such that it
> > > > believes it's fine. This is just as true in DRTM as it is in SRTM. But
> > > > you know what the expected measurements should be, so you're able to
> > > > either seal secrets to those PCR values or rely on remote attestation.
> > >
> > > In this scenario the kernel has no idea what the measurement should
> > > be, it only knows the measurement that a potentially malicious boot
> > > loader felt like giving the kernel previously (e.g. when the kernel
> > > was installed).
> >
> > Even if the kernel has an idea of what the measurement should be, it has
> > no way to verify that what it believes to be true is true - any
> > malicious code could simply have modified the kernel to believe that
> > anything it asks the TPM returns the "correct" answer.
> 
> Right. To achieve the best possible security; you'd need Secure Boot
> to ensure that the kernel itself wasn't modified, and then the kernel
> establishes a dynamic root of trust itself.

You can't rely on Secure Boot because compromised firmware might fail to 
implement it, so you're back to relying on dynamic trust.

> Anything involving a boot loader (e.g. Secure Boot ensure's boot
> loader wasn't modified, then boot loader ensure's kernel wasn't
> modified, then ....) increases the attack surface for no benefit.

I honestly feel like we're talking about different things. Can you 
describe the attack vector you're concerned about here?

> I'm not convinced an external agent can detect "bad/forged
> measurement" either. E.g. if a MiTM boot loader always provided a
> bad/forged measurement the external agent won't detect it (as the
> measurement always matches the expected measurement), and then if the
> MiTM boot loader is replaced by a good/honest boot loader the external
> agent will decide that the good/honest boot loader is malicious
> because its measurement doesn't match the expected bad/forged
> measurement.

The point of DRTM is that the platform (in the form of an authenticated 
code module running on the CPU, outside of the control of the OS) 
performs a measreument of a specific point in time. The policy it's 
provided with allows an external agent to identify which component of 
the runtime system is being measured. If an external malicious agent has 
been executed then the measurement will be different as a result.
