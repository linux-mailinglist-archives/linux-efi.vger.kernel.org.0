Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE564DC78B
	for <lists+linux-efi@lfdr.de>; Thu, 17 Mar 2022 14:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiCQN16 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Mar 2022 09:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiCQN1v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Mar 2022 09:27:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DE16C0A5;
        Thu, 17 Mar 2022 06:26:34 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 784C840D4004;
        Thu, 17 Mar 2022 13:26:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 17 Mar 2022 16:26:28 +0300
From:   baskov@ispras.ru
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bret.barkelew@microsoft.com
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
In-Reply-To: <20220303204759.GA20294@srcf.ucam.org>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
 <20220228183044.GA18400@srcf.ucam.org>
 <9787f1c1948cc640e70a50e4b929f44f@ispras.ru>
 <20220303204759.GA20294@srcf.ucam.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <9b8493626c3c6c0af415e0b277147f9e@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-03-03 23:47, Matthew Garrett wrote:
> 
> Ok. I think this should really go through the UEFI spec process - I
> agree that from a strict interpretation of the spec, what this firmware
> is doing is legitimate, but I don't like having a situation where we
> have to depend on the DXE spec.
> 
> How does Windows handle this? Just update the page tables itself for 
> any
> regions it needs during boot?

Sorry for delay.

Windows is closed source, so we cannot give guarantees on its
behavior, but this is our belief regarding its behavior.
Added Bret Barkelew (bret.barkelew@microsoft.com)
to the CC-list in case he can add something.

Regarding the spec changes, we agree it is reasonable,
but whether the spec changes or not it will take some time
to update the edk2.

Our first solution was safer in regards to the use of the services,
yet as Ard suggested, using DXE services is much cleaner
as long as it works.

We can post it to edk2-devel, but our opinion
is that these issues are independent.

Thanks,
Baskov Evgeniy
