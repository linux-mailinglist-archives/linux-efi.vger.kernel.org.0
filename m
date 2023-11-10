Return-Path: <linux-efi+bounces-22-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7537E77A2
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CC1B20ADB
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8464B;
	Fri, 10 Nov 2023 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IYkK6Zug"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA8365;
	Fri, 10 Nov 2023 02:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA8EC433C7;
	Fri, 10 Nov 2023 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699584025;
	bh=oK/F0THfOnSL0dIVkI2dvSL2cmYdL74DCbYIUCPytVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYkK6ZugBoRE3kStmDD3GmhR9zqm8yZ3vHUbGYoOCSlruwYI7ljkYjxSGlsrcD8QQ
	 +HhHewygGeQvmOhB2RmnhHG//frOWRgIX3mOclFbvf9K+eDmzSdmzcGHyzLZWfRmXI
	 9GwjAQNlb6HVnqzAiwtQmJ6R3vAhvrJJdXMqjVAg=
Date: Thu, 9 Nov 2023 18:40:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Will Deacon <will@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Rob Herring <robh@kernel.org>, Daniel
 Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Pratyush Brahma
 <quic_pbrahma@quicinc.com>, Tomas Mudrunka <tomas.mudrunka@gmail.com>, Sean
 Anderson <sean.anderson@seco.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier
 <nicolas@fjasle.eu>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kbuild@vger.kernel.org"
 <linux-kbuild@vger.kernel.org>, "linux-efi@vger.kernel.org"
 <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/8] generic command line v6
Message-Id: <20231109184024.80bfe8119da8c99b4737f31d@linux-foundation.org>
In-Reply-To: <ZU2T3VPYosP+ZR1b@goliath>
References: <20231110013817.2378507-1-danielwa@cisco.com>
	<20231109175142.49428d5f51325680764663bf@linux-foundation.org>
	<ZU2T3VPYosP+ZR1b@goliath>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 02:22:27 +0000 "Daniel Walker (danielwa)" <danielwa@cisco.com> wrote:

> On Thu, Nov 09, 2023 at 05:51:42PM -0800, Andrew Morton wrote:
> > On Thu,  9 Nov 2023 17:38:04 -0800 Daniel Walker <danielwa@cisco.com> wrote:
> > 
> > > This release is an up-rev of the v5 patches. No additional features have
> > > been added. Some changes were mode to function names and some changes to
> > > Kconfig dependencies. Also updated the config conversion for mips.
> > > 
> > > There are a number of people who have expressed interest in these
> > > patches either by asking for them to be merge or testing them. If
> > > people are so inclined please continue to request them to be merge
> > > or to ask the status of the next release. It's helpful to motivate me to
> > > release them again and for the maintainers to see the interest
> > > generated.
> > > 
> > > These patches have been used by Cisco Systems, Inc. on millions of
> > > released products to great effect. Hopefully they can be used by the
> > > entire Linux eco system.
> > > 
> > 
> > fyi, none of the above is suitable for a [0/N] changelog - it's all
> > transitory stuff which tells readers nothing much about what the
> > patchset does.
>  
> I did not think about it this way. It's because I've submitted this so many
> times. I guess I assume everyone knows what it is.

This is all on the path to the mainline git history.  Think about how
we want it presented to future readers.  10 years from now nobody will
remember the v5 series email spray.

> 
> > In [1/8] I see "Even with mips and powerpc enhancement the needs of
> > Cisco are not met on these platforms" and "This unified implementation
> > offers the same functionality needed by Cisco on all platform which we
> > enable it on".
> > 
> > Well OK, what are these needs?   What functionality changes does this
> > patchset offer which Cisco finds useful?  IOW, what were the
> > requirements?  What's wrong with the old code and how does this
> > patchset fix/enhance that?
> 
> The limitation is that you can't append and prepend to the command line at the
> same time in any of the architectures. Having access to both allows OEMs to deal
> with broken bootloaders which can't easily be upgraded.

I would never ever have guessed that from the emails I received!

> Others have responded
> that they also use these patches for this same reason.

Citing this info in the [0/N] would be useful.

> In 2/8 and 3/8 I modify the insert-sys-cert tool to allow modification of the
> command line append and prepend after the build. This allow for an SDK
> provided with a binary kernel and for the command line append/prepend to still
> be modified identically to how that's done with certificates.

And this.

> Making all this generic means each platform has a unified set of command line
> services. Cisco uses x86/arm32/arm64/mips/powerpc , and it's nice to have all
> the same features across platforms.

Sounds good.

> > 
> > I see the patchset updates nothing under Documentation/.  Should it do
> > so?  Could it do so?
> 
> The only documentation is Kconfig descriptions and commit messages. I suppose it
> could have something under Documentation/. The only part which could use more
> documentation are the changes in 2/8 and 3/8. That feature is maybe confusing
> and has limitations which are maybe not clear. Although the same limitation exist for
> inserting certificates.

Perhaps the new functionality could be described in
Documentation/admin-guide/kernel-parameters.rst

> > 
> > I don't know what is the expected merge patch for this work.  I can
> > grab them if no other maintainer is in the firing line.
> 
> merge patch ?

"path", sorry.

> Do you mean merge description ? I think your the maintainer in the
> firing line for this one.

OK.  

