Return-Path: <linux-efi+bounces-1642-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED349682A5
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A51FB2182A
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B84186E58;
	Mon,  2 Sep 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="blR1e5W/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221541547D2;
	Mon,  2 Sep 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267915; cv=none; b=C+SL+XwDig47tpxf/LrvL/t86B2VIHePY7xkOZNtpPbIvCok8Q9o2VVW35LbMBH87TrVcfvRSfXusdJ1y5AXmVVXa32x9x04rbQhsCVh7P1Ok68mQb5FzkirXC5VBVzyGFHW5IJtedYKTrNFAMbECB0ZpwPacbt5+Yh+/b9UXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267915; c=relaxed/simple;
	bh=47IhWIyyF9Z9QKoW1CtiwhIrW3cuU2agjCSA6CnRqqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cslQAxdV2ZnSHBs1uMsBbVGpJQFHtqzKQYY9sXvYX9YvuyRI3+FUp54kpxeFth+x144L7JUxJuLP8gC9/E/+WZmYdh98sqZY4X8C3H9tySqcQHdIQ2ijQMo88+sghRESZbs4gTOgJKwenq94Ldb6M1KeMq4+3/xh0h08DtrsXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=blR1e5W/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8470B40E0284;
	Mon,  2 Sep 2024 09:05:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dZlJ3mWUxFdV; Mon,  2 Sep 2024 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725267904; bh=kK1aL9WxF67VsbaboG2sxhPgSy1iVIzpPlT8ewxiaLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blR1e5W/R3RR5OlPxzvnsyzfMysS2Q6MRAbn4q+v/7cPd2ZQnYiOh90hpo4GII39D
	 neteg7YkJf1N1A7WaE+zimAxXEyDoram2qdLl0F/ZsfBl10y6+04o0yRmzFbItGg+k
	 eU1pMri/hcjktHN0c7/mR9E6i3Wy/Yx7ttsPGu/XDiTx+77rmyn6aSRBG3acV8aLtZ
	 mDCZyWnrouyC/jwps3ktxd/p+rjq+864upL8nwEwyaKd5Tyje8stT0VHkbGoFIsAN2
	 3KYmUzvTvYdTPT77o3B8JJeL83Sd6GKDOLwcNlrB1mtskhOHVR0UQUMyC5YkouYhWG
	 +vc5xAcNXCWa20Y9ujg8QVDZopnJ2+8mQlmjpWq5ysBMh7uPWWHmMh0judBcXFfkx/
	 mfJFA4yQoq+7VbzQVq3nCdVzIZRB59B2NXlysA0nuv8+uJGsMDc3tx/I/OQ7nfa5ui
	 kIQUnGIgeZPqTGi6hUzLuT0pdkulM8gxeGgydst/6fX9OmoJoNKWg32XN0EpVZ6IqS
	 O1OzUl4iTgbcevdNTx3pxPdFtXnJsmZfQcOT5tkNxW5sp72pu+XY3ZPliiInnpbbWT
	 7QBB6opnZ6AX5f7I3do7dO5VJTGoW5dPBb7m5Gx09NjyJkw6yHB62xm/XTY08n3K+2
	 ukPTn0QN4m/f61xORvs6e9QI=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE9AC40E0169;
	Mon,  2 Sep 2024 09:04:39 +0000 (UTC)
Date: Mon, 2 Sep 2024 11:04:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	Will Deacon <will@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shengwei Luo <luoshengwei@huawei.com>,
	Jason Tian <jason@os.amperecomputing.com>, m.chehab@huawei.com
Subject: Re: [PATCH v2 1/5] RAS: Report all ARM processor CPER information to
 userspace
Message-ID: <20240902090434.GAZtV_ooWloe-TYzO1@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
 <3853853f820a666253ca8ed6c7c724dc3d50044a.1720679234.git.mchehab+huawei@kernel.org>
 <20240829143811.GDZtCH07BFEdbbv9wx@fat_crate.local>
 <20240902061236.7cfc97fd@foz.lan>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902061236.7cfc97fd@foz.lan>

On Mon, Sep 02, 2024 at 06:12:36AM +0200, Mauro Carvalho Chehab wrote:
> Ok. Will address those at the hole series, sending you later today
> a new version. Except for those, are patches 2-5 ok?

Haven't looked at them yet.

> Usually, I don't use "this patch". In this specific case, I wanted
> to bold the new fields that were added to the ARM trace event, making
> clear that before the changeset, none of such fields exist; they were
> added on such change. On other words, the keyword here is not patch,
> but instead "After". Maybe I can replace it with "now", e. g.:

Yes, and you can see what you're doing in the patch itself.

> Anyway, it sounds that the custody chan can better be written as:
> 
> 	Co-authored-by: Jason Tian <jason@os.amperecomputing.com>
> 	Co-authored-by: Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> 	Co-authored-by: Daniel Ferguson <danielf@os.amperecomputing.com>  
> 	Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
> 	Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
> 	Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>  

The tag's name is Co-developed-by: and yes, I think it makes more sense here.

Note:

"Since Co-developed-by: denotes authorship, every Co-developed-by: must be
immediately followed by a Signed-off-by: of the associated co-author.
Standard sign-off procedure applies, i.e. the ordering of Signed-off-by: tags
should reflect the chronological history of the patch insofar as possible,
regardless of whether the author is attributed via From: or Co-developed-by:.
Notably, the last Signed-off-by: must always be that of the developer
submitting the patch."

It is all documented:

Documentation/process/submitting-patches.rst

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

