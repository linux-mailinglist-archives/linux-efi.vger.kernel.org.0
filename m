Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52A2D1476
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgLGPLI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 10:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgLGPLI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Dec 2020 10:11:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 731A12370D;
        Mon,  7 Dec 2020 15:10:27 +0000 (UTC)
Date:   Mon, 7 Dec 2020 10:10:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        laniel_francis@privacyrequired.com,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 07/12] efi: Replace strstarts() by
 str_has_prefix().
Message-ID: <20201207101025.1d133a5d@gandalf.local.home>
In-Reply-To: <8a169362defed5af16be78c5a11f4ff9f58da2a8.camel@HansenPartnership.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
        <20201204170319.20383-8-laniel_francis@privacyrequired.com>
        <CAMj1kXEQhT_LF5FDBO3-S7pBn55wG59bQUVr2q58A4FhqodY8Q@mail.gmail.com>
        <ab769a5188394cd3379cc627d14a0222050a1367.camel@HansenPartnership.com>
        <CAMj1kXFvCZKH-Bbvu-V5-GxcTun8yz98igeFxRc1tTswbttM0w@mail.gmail.com>
        <3161fc13d69c388b1f51f59c6ecea48dcd0a7856.camel@HansenPartnership.com>
        <CAMj1kXFZ1_05O=s37n7pJbFxRm_-hAVFHKqc6OtALfBMVZVYnQ@mail.gmail.com>
        <043040d9c092cedcab8bf88b0ec805616d3be44d.camel@HansenPartnership.com>
        <CAMj1kXHj0y9b+yGPDjyToFL6HYyyu23BuX3FMYmjGo5+6sgjUQ@mail.gmail.com>
        <8a169362defed5af16be78c5a11f4ff9f58da2a8.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 05 Dec 2020 15:04:31 -0800
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> Well, I think the pattern
> 
> if (strstarts(option, <string>)) {
>    ...
>    option += strlen(<same string>);
> 
> is a bad one because one day <string> may get updated but not <same
> string>.  And if <same string> is too far away in the code it might not  
> even show up in the diff, leading to reviewers not noticing either.  So
> I think eliminating the pattern is a definite improvement.

And one of the reasons we created str_has_prefix() is because we fixed that
exact bug, in a few places.

It was caused by a typo, where we had something like:

	strstarts(option, "foo=") {
		option += strlen("foo");

and forgot the "=" part, and broke the rest of the logic.

-- Steve
