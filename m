Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7924AD3A6
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 09:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350551AbiBHIlD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 03:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350716AbiBHIkl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 03:40:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3207C03FECF;
        Tue,  8 Feb 2022 00:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A1EB81768;
        Tue,  8 Feb 2022 08:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3918C340ED;
        Tue,  8 Feb 2022 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644309634;
        bh=Qiy8w7jKXrvvylMq4I38caclQvB6xxH3iqeR0R/bAX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUDaeUvMZt3A1enVwQB7jukcGLYXbBN7fpsIXaAJoaaTwm4vvtBbGFbBTV2uyduuO
         Vg4bsCVF0JvSBOfiYBx06D/MJk12aowlTO7UeZWZVJtpRBHBnqzMfv/VX3DgDG4BGn
         HXN5imdeHKqLGeLd4DucRK8RzLhpCpMgWXT3Mmo5tBDs8Y2fQWh8J1DI5HxEqnVl9I
         gpxI3Tj5NnJmMTJZnmM9y18QKvSCPvlFi575AeIdpIJXzv0HItdCRf6nUqQLSLg+yV
         PmV8eXKsOesdN/PS3TinZRCuchRF7RsNtlu6hSCiIZ2RKg0k6vSHZoNBP2sfBDNU7g
         yF3XklW7bPQdg==
Date:   Tue, 8 Feb 2022 10:40:24 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
Message-ID: <YgIseIEMotD2jg83@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com>
 <202202071325.F8450B3B2D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202071325.F8450B3B2D@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 07, 2022 at 01:45:40PM -0800, Kees Cook wrote:
> On Thu, Feb 03, 2022 at 01:43:25PM -0300, Martin Fernandez wrote:
> > __e820__range_update and e820__range_remove had a very similar
> > implementation with a few lines different from each other, the lines
> > that actually perform the modification over the e820_table. The
> > similiraties were found in the checks for the different cases on how
> > each entry intersects with the given range (if it does at all). These
> > checks were very presice and error prone so it was not a good idea to
> > have them in both places.
> 
> Yay removing copy/paste code! :)

Removing copy/paste is nice but diffstat of

 arch/x86/kernel/e820.c | 383 ++++++++++++++++++++++++++++++-----------
 1 file changed, 283 insertions(+), 100 deletions(-)

does not look nice even accounting for lots of comments :(

I didn't look closely, but diffstat clues that the refactoring making
things much more complex.
 
> > 
> > I propose a refactor of those functions, given that I need to create a
> > similar one for this patchset.
> 
> The diff here is pretty hard (for me) to review; I'll need more time
> to check it. What might make review easier (at least for me), is to
> incrementally change these routines. i.e. separate patches to:
> 
> - add the new infrastructure
> - replace e820__range_remove
> - replace __e820__range_update
> 
> If that's not actually useful, no worries. I'll just stare at it a bit
> more. :)

-- 
Sincerely yours,
Mike.
