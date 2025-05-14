Return-Path: <linux-efi+bounces-3696-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43981AB65C8
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 10:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F77E189E2AC
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980121C183;
	Wed, 14 May 2025 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fo2WMeMu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027D2063F0;
	Wed, 14 May 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210935; cv=none; b=HgoK13U4Ygf9dLkJD2M28bkyrW3uxLLBimtyBDKFhdj7gsJigA8dEaDQV9Rblhmo7AEeeH8od9IYCwO1vzr+Fd6VcG8fOOUwzLh04f6WJGW2D5oADWVg2Sk2+7zQviZr1JtTcSOFj2IWOCl4HDFlz6Yw3Rio7PgJNvJ3tsMBikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210935; c=relaxed/simple;
	bh=g4ftrT3Y1diYK/vCIN1dyaP/i3jvVe8cYbbMXbhVDSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu3SfS1bgtkYDT69mGY/LTlP53fGjnAjH9fYnd4SfeLWaeYJ/yg5HZG1iKw5EUuzNG02SMZAC4Tx3oKl9jGAAXYiMGjlKyiMCYbKhBqP65I1UwaHG5FNVzxi560bG2HfFgCxow33wGyl8lhPk7J5qs/2RdiMoDBkn0e4tOrc8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Fo2WMeMu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC7F140E0163;
	Wed, 14 May 2025 08:22:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UBpfIHn--jso; Wed, 14 May 2025 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747210927; bh=+Nwf+c9pXNlMrfiw/N5h45Pxm/oamtWzy4ZxIo6/j3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fo2WMeMu8CA3WlfstGOdLaFGlaRAifEjv4CoUvd1TQzW32iEMwJp98hEVIQiJDFom
	 BBp2IjmB3GVWTuy1AiUpXTU8TqsEzmfGqYf/88W6BV7qs9VCsszaSTFDhfLXlFQ90D
	 xl/mlnt/B/zpgIvTuE7JEXn74kDXZ2TQKgWJHLddvq5D5xq3EkucE5iQY9xOcCGEHo
	 YvBzCLlmKZjFg9pn7Zaceqem6MDyNRxKoILQma4VCrotwVBKYKdBDsFw6PjE0mCw98
	 cH9wMLlXSvXfTbwy/ZnnR8kNg03dAhyF43M3ZlM5nbQHC/Gy5Pi9JH9/DVIM5rZPke
	 upLDQGdhVkydsAmIweJPPV8p0F1evxBMh1vN2gpkBjPiT0wJ2DI+KO1XKuvn23MKl3
	 jHSlUY3tNjQ93mZaGKlMOSLlwtwCVl0eYT+QMO4Q61tx3ceEHxj+JXhUbFP9HFoB4u
	 FKwBzTAb163MRjsWJACzDg+8O0ZXYaMabZkLMztAdPPopmjFjTmYU8WInZ/fyPuibT
	 Aw3YwnTe+WhtBei2VLUTUbl1O7lsucNHkyWMJPBu65xEKjtgMHjwh4kxlNkjKQAjmD
	 Fmaiahuv7SCBi1qcjKtFQkoEpJOQbAUtf7w3aLgQX4qHkVUWyJ9fTLmOAhfMjs5+lO
	 Zz4Zk6HL8jter8KqUPckU5yQ=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF58F40E0266;
	Wed, 14 May 2025 08:21:57 +0000 (UTC)
Date: Wed, 14 May 2025 10:21:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
Message-ID: <20250514082157.GCaCRSpffav0xWQ586@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512191705.GHaCJJMcpPTS4ioLpm@fat_crate.local>
 <aCMYrgd9DDQl7G1W@gmail.com>
 <20250513101250.GAaCMbIpk6kdVMizng@fat_crate.local>
 <aCMraFZ2yJQNyHf3@gmail.com>
 <20250513141633.GDaCNUQdRl6ci2zK5T@fat_crate.local>
 <aCQ2L3L2DQX80blY@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCQ2L3L2DQX80blY@gmail.com>

On Wed, May 14, 2025 at 08:20:31AM +0200, Ingo Molnar wrote:
> See Ard's excellent description:

Btw, you somehow conveniently ignored the patch Ard mentioned started all
this: a patch you committed without any review.

Sounds familiar?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

