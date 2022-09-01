Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161F5AA2A8
	for <lists+linux-efi@lfdr.de>; Fri,  2 Sep 2022 00:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiIAWOg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 18:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiIAWOG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 18:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BD8E0D1;
        Thu,  1 Sep 2022 15:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25919B8293A;
        Thu,  1 Sep 2022 22:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D56EC433D6;
        Thu,  1 Sep 2022 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662070401;
        bh=zwd18V2QD6mKxMLr4b2ayLHDv2ZIOioa9kGBsxbZMDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQhYqSryXmbpo53jGCmkOvf59myUwo45I8dyhrnTV+5gLLd00XAdBbCTD4AAJqXMn
         nF1t+dzdIEhBUdylRp4wQp8k3XTxnA9PVbBDr0OVHYAGrs3uzYzuzZU5HS3uQcKrvz
         AotrDAEY6IBQeeSXnxUVHBdO11mMGcl7YF7yJ0EI=
Date:   Thu, 1 Sep 2022 15:13:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, evgreen@chromium.org,
        arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to
 avoid lockups
Message-Id: <20220901151320.3cff1767f88cfb33f394e9cb@linux-foundation.org>
In-Reply-To: <794efe45-2fef-0d3f-b6d0-f2f451be850c@igalia.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
        <YxDVPqVkdgQbAIvY@kroah.com>
        <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
        <YxDX9+p+58q2sip2@kroah.com>
        <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
        <YxDhiSDs4YcUrqV5@kroah.com>
        <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
        <YxD56RTI9v/P2QOL@kroah.com>
        <b050f00b-6c3a-a0d9-a3c1-175a724faf1c@igalia.com>
        <YxEBCVRgWE8VTZaf@kroah.com>
        <794efe45-2fef-0d3f-b6d0-f2f451be850c@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 1 Sep 2022 16:02:08 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> On 01/09/2022 15:59, Greg KH wrote:
> > [...]
> > Ick, I don't know, this all feels odd.  I want someone else to review
> > this and give their ack on the patch before I'll take it so someone else
> > can share in the blame :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> LOL, that's OK for me! Evan seems to be fine with it BTW.
> 
> Let's see if Petr can jump in, also adding Andrew here since he's
> usually merging stuff for panic.

Are the usual gsmi developers not operational?

Patch seems sensible to me, although the deadlock sounds pretty
theoretical.  A better code comment might be simply

	/*
	 * Panic callbacks are executed with all other CPUs stopped, so we must
	 * not attempt to spin waiting for gsmi_dev.lock to be released.
	 */

?
