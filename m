Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F456B216
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 07:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiGHE4p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Jul 2022 00:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiGHE4o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Jul 2022 00:56:44 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E576E96;
        Thu,  7 Jul 2022 21:56:42 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 3424340A61; Fri,  8 Jul 2022 05:56:38 +0100 (BST)
Date:   Fri, 8 Jul 2022 05:56:38 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Brendan Trotter <btrotter@gmail.com>
Cc:     "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        The development of GNU GRUB <grub-devel@gnu.org>,
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
Message-ID: <20220708045638.GA27939@srcf.ucam.org>
References: <20220329174057.GA17778@srcf.ucam.org>
 <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
 <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 08, 2022 at 01:06:19PM +0930, Brendan Trotter wrote:

> This leaves me wondering what your true motivation is. Are you trying
> to benefit GRUB/Trenchboot (at the expense of security, end-user
> convenience, distro installer hassle, etc); or trying to manufacture
> scope for future man-in-the middle attacks (by promoting a solution
> that requires something between firmware and kernel)?

The described mechanism doesn't require trusting the code that's in the 
middle - if the state is perturbed by this code, the measurements will 
be different, and the system will be untrusted. I agree that this 
implementation is more complicated than just leaving it all up to the 
kernel, but I'm having a *lot* of trouble seeing how this has any impact 
on its security. Jumping immediately to impugning the motivation of the 
people involved is entirely inappropriate.
