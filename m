Return-Path: <linux-efi+bounces-3210-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E3A7E736
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453273B4ABB
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5725120F09F;
	Mon,  7 Apr 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/9nqidF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55C20E6FD;
	Mon,  7 Apr 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044270; cv=none; b=OC2h4SwEkYVtwAmfbXE/gIBjqp4LCx2XCwZk4bX9DrIUWACZSs5qExHziLDZ53pqsqimRGLHSwkKnB0tOP3HSbXrYhzFTmjiLPYAzdtQTwdeSe1jIlZMTXH7mPwd0FBJKdRvtsFq/mPySE28Ig2wX5xbaC7H7sOroEksEXob1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044270; c=relaxed/simple;
	bh=U4QP9GpHrMLxSbhKQjhxSGJni9KV11P9PQ+zwNhKAy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUYpfF2fpsg84yGyvTn+O2KLhDVQ8Lwc8ZkYzMdeP24Ia/UYFz+Dnv6sT0B+EzJXTPyr1jW30H9cvka+rC6vi9Oer9tJ722gNpRc6ZRLVl++5GwHa8LssuHw4WG74CIoPl2phiDrmxTuB1IGbov5EjIYSk5heHSpfOSvsCoJXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/9nqidF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4DEC4CEDD;
	Mon,  7 Apr 2025 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044270;
	bh=U4QP9GpHrMLxSbhKQjhxSGJni9KV11P9PQ+zwNhKAy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/9nqidFoAXn3MHMFqSLV++sf67bHM3Cb6Ewz2bBl4x+R2f6v7qiLw/kEaQXlhiUU
	 RaEVd6XoPE+0cnP89g+1GgK88idM8DEjiQikUx6ZOr/9HNA2sqy0T/wdog2W0XRCou
	 oFYIn0CQY4JrC7QqpeIC2sNzmzRqHuYfHFWowDtKDkBJtie5Oa9CpLzefmajT9i0gM
	 puX8p9PY5a6cQQPEl+ECBFiTtg7WBDcrB50AG4fqaJCfFOLZe39ZyeyhSsWzQxUdhF
	 vT5q2T8pAo8MQnAXY3lOuRcnHJKeR2b13WDTksZjyggjpEJY+xHHfOGQ5TCg2xfIDr
	 1Z38YBA1omLlw==
Date: Mon, 7 Apr 2025 18:44:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
Message-ID: <Z_QA6GwqoxdW6D0e@gmail.com>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
> > If the GHCB is available, we should always prefer it.
> 
> I believe we should consider the cost of code duplication in this
> situation.
> 
> If the non-early version is only used in the kexec path, it will not be
> tested as frequently and could be more easily broken. I think it would be
> acceptable for kexec to be slightly slower if it results in more
> maintainable code.

Absolutely so.

Thanks,

	Ingo

