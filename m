Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9FA4B6407
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 08:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiBOHLT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 02:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBOHLT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 02:11:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2CA8EFF;
        Mon, 14 Feb 2022 23:11:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60F13B817E1;
        Tue, 15 Feb 2022 07:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BB7C340EC;
        Tue, 15 Feb 2022 07:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644909064;
        bh=loxfJNPJZCU7xFx+mlZ0BgFDRoU9Xb7lz1Nf2gofob4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+14GcqnJPUq2wfMoDt80IZWh46UZJ1BScWaCynkF9GrXmpRwbdJLstkoFB6V8goZ
         nim1a1iRTWP6M+BmkpAQXalD0apKYgwqGl5Gv83xEhYgj2J6d5curnMQ7U1ADVB3Fl
         0yuplf1b12BgRgG58UEkbvDz9B7xfvYXLtAjEJniuy4DUkGYRp8IAf+wcQAJ3CWRQc
         WYy5y2T53S7KcVaTvMERdo/Tdfrvgm4FhwSPtrbjZ5/akfYgv+tZxm0DiJs/YJdlsL
         b0MFRHea8Ceih/3Q6HI6rk8Iw9NxnXrZNUL8RpeBnVq3+sWx+elkdebPzYaVJjZMKP
         GHUkatxLlvmKQ==
Date:   Tue, 15 Feb 2022 09:10:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
Message-ID: <YgtR++NUG3w6DH11@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com>
 <202202071325.F8450B3B2D@keescook>
 <YgIseIEMotD2jg83@kernel.org>
 <CAKgze5a_o=+f6fE55p4D50qZSRNUEHUWBe+Fn8Fc=1RjFLfgeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5a_o=+f6fE55p4D50qZSRNUEHUWBe+Fn8Fc=1RjFLfgeQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Martin,

On Tue, Feb 08, 2022 at 06:01:21PM -0300, Martin Fernandez wrote:
> On 2/8/22, Mike Rapoport <rppt@kernel.org> wrote:
> > On Mon, Feb 07, 2022 at 01:45:40PM -0800, Kees Cook wrote:
> >> On Thu, Feb 03, 2022 at 01:43:25PM -0300, Martin Fernandez wrote:
> >> > __e820__range_update and e820__range_remove had a very similar
> >> > implementation with a few lines different from each other, the lines
> >> > that actually perform the modification over the e820_table. The
> >> > similiraties were found in the checks for the different cases on how
> >> > each entry intersects with the given range (if it does at all). These
> >> > checks were very presice and error prone so it was not a good idea to
> >> > have them in both places.
> >>
> >> Yay removing copy/paste code! :)
> >
> > Removing copy/paste is nice but diffstat of
> >
> >  arch/x86/kernel/e820.c | 383 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 283 insertions(+), 100 deletions(-)
> >
> > does not look nice even accounting for lots of comments :(
> >
> > I didn't look closely, but diffstat clues that the refactoring making
> > things much more complex.
> >
> 
> Yes, that diffstat surprised me as well.
> 
> I have to mention that 110 of those lines are kerneldocs and blank
> lines, which is quite a lot. Also you have to take into account that I
> expanded most of the function definitions for better formatting, which
> also took some space.

At last I had time to look more closely and I think that using a set of
callbacks is over-complicated.

I think this can be done way simpler, e.g like this (untested) draft:

https://git.kernel.org/rppt/h/x86/e820-update-range


> And as I was able to focus the "hard" part of the problem into a
> single function, testing can be done easily as Kees suggested and I'm
> planning to do so in the next patch.



-- 
Sincerely yours,
Mike.
