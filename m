Return-Path: <linux-efi+bounces-20-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02217E76D6
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 02:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8821EB20DEF
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 01:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB4EA4;
	Fri, 10 Nov 2023 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W5NK1hJg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F83A47;
	Fri, 10 Nov 2023 01:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D84AC433C8;
	Fri, 10 Nov 2023 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699581104;
	bh=lxHFf+cJVyuGyX81+L2NmmRwViLV5SlJHHQH9byJyfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5NK1hJgRBAVp5r2VqL12zxpJ8rvnR5T+pYrM8pR+cz343NvxRUsURFNl1RJdu4Ms
	 +jIItb/Kb0CiAfLpjCyjC59peLSsmErjgsurwkNzmxSnQLR8TbSiUTVYv9ILJfRS/w
	 HiD/fJvaSgA6zFNJP+HT+qcJ9MImLla9ZAmHdYQA=
Date: Thu, 9 Nov 2023 17:51:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Walker <danielwa@cisco.com>
Cc: Will Deacon <will@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Rob Herring <robh@kernel.org>, Daniel
 Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Pratyush Brahma
 <quic_pbrahma@quicinc.com>, Tomas Mudrunka <tomas.mudrunka@gmail.com>, Sean
 Anderson <sean.anderson@seco.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "H. Peter Anvin"
 <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] generic command line v6
Message-Id: <20231109175142.49428d5f51325680764663bf@linux-foundation.org>
In-Reply-To: <20231110013817.2378507-1-danielwa@cisco.com>
References: <20231110013817.2378507-1-danielwa@cisco.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Nov 2023 17:38:04 -0800 Daniel Walker <danielwa@cisco.com> wrote:

> This release is an up-rev of the v5 patches. No additional features have
> been added. Some changes were mode to function names and some changes to
> Kconfig dependencies. Also updated the config conversion for mips.
> 
> There are a number of people who have expressed interest in these
> patches either by asking for them to be merge or testing them. If
> people are so inclined please continue to request them to be merge
> or to ask the status of the next release. It's helpful to motivate me to
> release them again and for the maintainers to see the interest
> generated.
> 
> These patches have been used by Cisco Systems, Inc. on millions of
> released products to great effect. Hopefully they can be used by the
> entire Linux eco system.
> 

fyi, none of the above is suitable for a [0/N] changelog - it's all
transitory stuff which tells readers nothing much about what the
patchset does.

And that info is sorely missed.  I can see that it's a code cleanup,
but I'm sure Cisco wouldn't expend resources to maintain such a thing. 
There's something else here.

In [1/8] I see "Even with mips and powerpc enhancement the needs of
Cisco are not met on these platforms" and "This unified implementation
offers the same functionality needed by Cisco on all platform which we
enable it on".

Well OK, what are these needs?   What functionality changes does this
patchset offer which Cisco finds useful?  IOW, what were the
requirements?  What's wrong with the old code and how does this
patchset fix/enhance that?


I see the patchset updates nothing under Documentation/.  Should it do
so?  Could it do so?


I don't know what is the expected merge patch for this work.  I can
grab them if no other maintainer is in the firing line.

