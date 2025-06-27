Return-Path: <linux-efi+bounces-4036-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCEAEB53D
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C397A328F
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEB2989A2;
	Fri, 27 Jun 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="clLb8u2D"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8125F78A;
	Fri, 27 Jun 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021096; cv=none; b=Oew3Npo0LU4gkrIwViTr2vTBONeeMrqXer4B6oIi7GR1KoHuuyBWjSI/CVbItgkt3UyCrsalrT6+pBVuSjbZnO7ZyR29v9BoLbNzG4leR0WCwawaHw74PwIzYPLC+0Uqc0hLZtdsXp2fJ0vmwDtrmyICkbByLmrrpZN+wwLS2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021096; c=relaxed/simple;
	bh=UW1XxyK/q8J4LcUzX/QxvqaTgCo+063etzUhicM0QS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrfgWqFJbIxl6Rh+MnY6cdiy/gCzqzYSrviheQEaDL0mLllX6XTbx32yUgPNU5a4E/qYv33F1KLo8jMmcIJshmavsuup1u54oba1UCFVJ8qa6uWhhfElRvqRBETdSBTjVlT/58uluQRDALOPn0ZVUw9+3MRn5Adc6xVOuh92O7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=clLb8u2D; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E2E040E0198;
	Fri, 27 Jun 2025 10:44:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hnpk4H810n2U; Fri, 27 Jun 2025 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751021085; bh=eb2jDeAuL90LH9hBVHxfGvA66rkLmOa5hvria1KI0bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clLb8u2D+lKil0n6vyucenwYrHfBoBI8cNhonsgkLy41S03+HQKKD93BPKx4uyk6G
	 YBI619+U2rO6f6MCGaNpkMrlt5MXVyOg3z7RKJzA2agjbw0nxsCr9ecUo/mS3XRkNK
	 ROkZWhTpoJP8wMvTN8fx1+Bnl6vGVpP1dDjvdD38y9YG9z77Y5RelfSiHRse3Zk4ON
	 qq6+eQ8yJqp1k8weWdEhloRYPfOGSYi8XgIyMeE/srmqCPMze/aNtQL9da7d80ewWy
	 go3u6y93Adu0IrMteA8d+W0AI5InaAvM5/DMyNA1JoMZB9iZsy4fvjGsSMnL4gWHFO
	 Eo94Eq9FnuiwSgNWVOy/Vn+STVQWO1jURl6WTMQWrLkCvr5+RJAKc5WVk2co9UhWl2
	 u0xIKQxjQd3Q9MsUQNMc1Ncn8ZN0hgfY21xLHYyr63YE07r0TkQtYNfudKwJmDpM2K
	 ho7C07sRx8y5tmj2ZePR0ymi5NdimaUU2Iz3tP2AZF8LNmGUaCI4pEGwNYIlS6HBvE
	 1vvzEzXAwBt9Qj1b4qAH7gOcwuS3FQzvsQOecLMU54c7iPJ5uNXOYDgJjL7lOishCx
	 lGgdkqJIe1qOsX4hXL47tvQYcKHhLPMoAwyeyRWGkNTTFeFHet4VgFiO/TDA2bPkgI
	 CsLOhZawAa6TvUhFi785L3mY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA51040E00DC;
	Fri, 27 Jun 2025 10:43:51 +0000 (UTC)
Date: Fri, 27 Jun 2025 12:43:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <20250627104345.GAaF514fH1qDKP9FA6@fat_crate.local>
References: <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
 <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
 <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>
 <ztkgdk72p2z3q6z4hslfg4gj6pejirh7cnssxhd7u72mo4enn4@viqrwrycderf>
 <20250626151837.GFaF1kzfLtesXLqaAQ@fat_crate.local>
 <20250626160707.GGaF1wK5tW37P6xt0O@fat_crate.local>
 <2768baad-1b1f-40c2-9cd9-9f4489e14f4d@intel.com>
 <h47uwzno7oqer72sjwyc4spxaduggqi4meccjvai6v42iwnqnh@uhloooww25mo>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <h47uwzno7oqer72sjwyc4spxaduggqi4meccjvai6v42iwnqnh@uhloooww25mo>

On Fri, Jun 27, 2025 at 01:25:12PM +0300, Kirill A. Shutemov wrote:
> So, we want an entry for SLAM?
> 
> I don't think it is very useful as we don't allow LAM if LASS is missing.

Nah, it is all clear now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

