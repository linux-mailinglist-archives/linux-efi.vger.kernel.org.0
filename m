Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2159064C
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiHKSZI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHKSZI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 14:25:08 -0400
X-Greylist: delayed 88703 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Aug 2022 11:25:03 PDT
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BC9753E;
        Thu, 11 Aug 2022 11:25:03 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 2E2B040A56; Thu, 11 Aug 2022 19:25:02 +0100 (BST)
Date:   Thu, 11 Aug 2022 19:25:02 +0100
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
Message-ID: <20220811182502.GA32433@srcf.ucam.org>
References: <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
 <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
 <CAELHeEe5H8BNf8K22XRm3hXf=_imHBnf-MHcFYvPCXX7GYkt4w@mail.gmail.com>
 <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
 <CAELHeEe2CiTXfMf3OYu3bzc_kH=rs4qzC-4XQL12AM=Nq8Csjw@mail.gmail.com>
 <20220810174638.GA7906@srcf.ucam.org>
 <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 11, 2022 at 07:25:58PM +0930, Brendan Trotter wrote:
> Hi,
> 
> On Thu, Aug 11, 2022 at 3:16 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > The kernel has no way to know this - *any* code you've run before
> > performing a measurement could tamper with the kernel such that it
> > believes it's fine. This is just as true in DRTM as it is in SRTM. But
> > you know what the expected measurements should be, so you're able to
> > either seal secrets to those PCR values or rely on remote attestation.
> 
> In this scenario the kernel has no idea what the measurement should
> be, it only knows the measurement that a potentially malicious boot
> loader felt like giving the kernel previously (e.g. when the kernel
> was installed).

Even if the kernel has an idea of what the measurement should be, it has 
no way to verify that what it believes to be true is true - any 
malicious code could simply have modified the kernel to believe that 
anything it asks the TPM returns the "correct" answer.

> > Measurements are not opaque objects. If you're not able to reconstruct
> > the expected measurement then you're doing it wrong.
> 
> OK; so to detect if boot loader has always given kernel a bad/forged
> measurement; the kernel repeats all of the steps involved in creating
> the measurement itself exactly the same as the boot loader should have
> (but might not have) so that kernel can compare a "known
> good/trustworthy" measurement with the useless measurement that the
> boot loader created for no sane reason whatsoever?

No, some external agent does. Code running on the local machine can 
never determine whether the machine is trustworthy.
