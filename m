Return-Path: <linux-efi+bounces-5627-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4EC77E8E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 09:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A08E32A12D
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FF33B961;
	Fri, 21 Nov 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icBxCpAo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0C33B6ED;
	Fri, 21 Nov 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713809; cv=none; b=MC7Uy6QsCj6pfUZg96Ll9Hg1/95GmE2yNaUAkCcfFaWeHjedx7Y6czTAwDlLwbBplY0wTa1pceGuxRcjLzoByIbYJ6PErzrVoJPfH7zjU3NmdGaSPY4qBxtWpUv/HUXRIM6e+Q0DCHgWKybBh06FY3DAeQ/l9BhgR26x6hN1wxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713809; c=relaxed/simple;
	bh=UebrCM8ZgZMn8LQGSIROx+8tEIsDHzwRTJoeAwz824A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJijagkZ0soQFwFvFTJ2Ue0A+B2ft7+X5qiYyJTILnUcqu468Ru8Kr+tNzvM+ERERTXol0zzbWMXs5RhB2l8XZU5CjGIC+FBRZd2fZ/KIdv6FLzmY8C8qc6IPZ5WiZdiZuYfK3KNpntHWtzsE/GEyX1EzIq472IoeMc9Q+VGoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icBxCpAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE695C4CEF1;
	Fri, 21 Nov 2025 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763713808;
	bh=UebrCM8ZgZMn8LQGSIROx+8tEIsDHzwRTJoeAwz824A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=icBxCpAoEIPHVB/ZSlCG4k5XNGYG0doJSk1JQBKjf35Q3+406a5S0biq2X1n/d3nk
	 tZnrlXMMjYb+keUzmCh1U0Wu5zvjaukHkPwh3vW+YyqGH1Ev3bPU53F82MPnj9Manz
	 e6i7W4RSSZTy82yXqOy1bNT4/0K0oG9PmvglExph7lzbvKEiP+BFAgRjlt0UBllAuP
	 rLiuLvA88lPK53T+tN+cdCNo/sYurax2cC5FbvBtVNx0Mf3blhER6f/TnIJTAmmR/l
	 fD3QjeSMgadjukEJj5qcd4HUGPnx0WSuIIzzMrqHmS9vM0GBNNKvZMkHZ0qU+9FXxp
	 PyOMYaEMt1jiA==
Date: Fri, 21 Nov 2025 09:30:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Daniel Ferguson <danielf@os.amperecomputing.com>, Ard Biesheuvel
 <ardb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, James
 Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, Jason Tian
 <jason@os.amperecomputing.com>, Shengwei Luo <luoshengwei@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>
Subject: Re: [PATCH v6 0/5] Fix issues with ARM Processor CPER records
Message-ID: <20251121093001.40e01849@foz.lan>
In-Reply-To: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
References: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Aug 2025 09:52:51 -0700
Daniel Ferguson <danielf@os.amperecomputing.com> escreveu:

> This is needed for both kernelspace and userspace properly handle
> ARM processor CPER events.
> 
> Patch 1 of this series fix the UEFI 2.6+ implementation of the ARM
> trace event, as the original implementation was incomplete.
> Changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
> added such event, but it reports only some fields of the CPER record
> defined on UEFI 2.6+ appendix N, table N.16.  Those are not enough
> actually parse such events on userspace, as not even the event type
> is exported.

Hi Rafael/Ard,

What's the status of this series? I'm not seeing it yet on linux-next.

Regards,
Mauro

> 
> Patch 2 fixes a compilation breakage when W=1;
> 
> Patch 3 adds a new helper function to be used by cper and ghes drivers to
> display CPER bitmaps;
> 
> Patch 4 fixes CPER logic according with UEFI 2.9A errata. Before it, there
> was no description about how processor type field was encoded. The errata
> defines it as a bitmask, and provides the information about how it should
> be encoded.
> 
> Patch 5 adds CPER functions to Kernel-doc.
> 
> This series was validated with the help of an ARM EINJ code for QEMU:
> 
> 	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submission
> 
> $ scripts/ghes_inject.py -d arm -p 0xdeadbeef -t cache,bus,micro-arch
> 
> [   11.094205] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
> [   11.095009] {1}[Hardware Error]: event severity: recoverable
> [   11.095486] {1}[Hardware Error]:  Error 0, type: recoverable
> [   11.096090] {1}[Hardware Error]:   section_type: ARM processor error
> [   11.096399] {1}[Hardware Error]:   MIDR: 0x00000000000f0510
> [   11.097135] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
> [   11.097811] {1}[Hardware Error]:   running state: 0x0
> [   11.098193] {1}[Hardware Error]:   Power State Coordination Interface state: 0
> [   11.098699] {1}[Hardware Error]:   Error info structure 0:
> [   11.099174] {1}[Hardware Error]:   num errors: 2
> [   11.099682] {1}[Hardware Error]:    error_type: 0x1a: cache error|bus error|micro-architectural error
> [   11.100150] {1}[Hardware Error]:    physical fault address: 0x00000000deadbeef
> [   11.111214] Memory failure: 0xdeadb: recovery action for free buddy page: Recovered
> 
> - 
> 
> I also tested the ghes and cper reports both with and without this
> change, using different versions of rasdaemon, with and without
> support for the extended trace event. Those are a summary of the
> test results:
> 
> - adding more fields to the trace events didn't break userspace API:
>   both versions of rasdaemon handled it;
> 
> - the rasdaemon patches to handle the new trace report was missing
>   a backward-compatibility logic. I fixed already. So, rasdaemon
>   can now handle both old and new trace events.
> 
> Btw, rasdaemon has gained support for the extended trace since its
> version 0.5.8 (released in 2021). I didn't saw any issues there
> complain about troubles on it, so either distros used on ARM servers
> are using an old version of rasdaemon, or they're carrying on the trace
> event changes as well.
> 
> ---
> v6:
>  - fix typo in Jonathans "reviewed-by" in patch 3
>  - Link to v5: https://lore.kernel.org/linux-acpi/20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com
> 
> v5:
>  - fix a few code formatting issues
>  - remove "Co-developed-by: danielf" because his/my contribution was
>    removed in v2.
>  - adjust tag block
>  - Link to v4: https://lore.kernel.org/linux-acpi/20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com
> 
> v4:
>  - rebase to kernel v6.16
>  - modify commit message of patch 1, and adjust white spaces
>    per Boris' suggestions.
>  - Link to v3: https://lore.kernel.org/linux-acpi/cover.1725429659.git.mchehab+huawei@kernel.org
> 
> v3:
>  - history of patch 1 improved with a chain of co-developed-by;
>  - add a better description and an example on patch 3;
>  - use BIT_ULL() on patch 3;
>  - add a missing include on patch 4.
> 
> v2:
>   - removed an uneeded patch adding #ifdef for CONFIG_ARM/ARM64;
>   - cper_bits_to_str() now returns the number of chars filled at the buffer;
>   - did a cosmetic (blank lines) improvement at include/linux/ras.h;
>   - arm_event trace dynamic arrays renamed to pei_buf/ctx_buf/oem_buf.
> 
>     
> 
> ---
> Changes in v6:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v5: https://lore.kernel.org/r/20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com
> 
> Jason Tian (1):
>       RAS: Report all ARM processor CPER information to userspace
> 
> Mauro Carvalho Chehab (4):
>       efi/cper: Adjust infopfx size to accept an extra space
>       efi/cper: Add a new helper function to print bitmasks
>       efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
>       docs: efi: add CPER functions to driver-api
> 
>  Documentation/driver-api/firmware/efi/index.rst | 11 +++--
>  drivers/acpi/apei/ghes.c                        | 27 +++++------
>  drivers/firmware/efi/cper-arm.c                 | 52 ++++++++++-----------
>  drivers/firmware/efi/cper.c                     | 62 ++++++++++++++++++++++++-
>  drivers/ras/ras.c                               | 40 +++++++++++++++-
>  include/linux/cper.h                            | 12 +++--
>  include/linux/ras.h                             | 16 +++++--
>  include/ras/ras_event.h                         | 49 +++++++++++++++++--
>  8 files changed, 210 insertions(+), 59 deletions(-)
> 



Thanks,
Mauro

