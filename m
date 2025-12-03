Return-Path: <linux-efi+bounces-5788-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F8CA106E
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 19:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8051D300D494
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A692305048;
	Wed,  3 Dec 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X33v0Y84"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3226059D
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784942; cv=none; b=BQGdLTRNbFGCEDootXYYn21BANpnA4NC0F1aydkP5ojdpq1DyaUKDbm43evftnqfe4pyYDq358YFzdZByQa0cML4daDABkmGFxfXLGM74JJCxoZ3nOs4eXHRzmWjsS6X75ZBfyCpmef/32iCf+KmPSwQ94yywxPFD14P+d/yIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784942; c=relaxed/simple;
	bh=BvmAws+7BickkUuwVGpea4WpLtEaqudqsT7t/9G2GKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQi+49bBaSJ0TqNImCPRBqd/lXW+AWt9FOIrazGK17DDUTnX1LE5JI1QRbEulT8YpHOsgROf4O0zW5+MYiKf7TSMlYa2zeOcE7phhzIGYNROC4nTAbcLyGA5ImrsGU/YnEA3UvcnMWn2ySTtUX/11FNEDWaBaVuYVb7nVLRTF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X33v0Y84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB9C4CEF5;
	Wed,  3 Dec 2025 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784942;
	bh=BvmAws+7BickkUuwVGpea4WpLtEaqudqsT7t/9G2GKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X33v0Y84I9KFSPcADczllxUu4p24D++/UKtRy3tw1X+Vx9RahyQURKnSsjiLCiBrW
	 TlxBwFyIUslsicwyP38oyWnCkMy4f4cpV0Q6Kj69iYiSQEvdJBWhzK2Es3iy+QApnl
	 6LM4V+CrWt+IzxPdb42BXtrZ8JzWZ9pAYtNTHEkQlYiEOuRBUz6XFaDtkIswZnh9Pb
	 NlImH1OLh+FRvQnVsfFuOUTtdzB8+keuaw74PspvXyi/vh8th/ai/3ft+xmTj54EiH
	 6fsHpzJDnZVdb46j/DsB74nK9fhyHQv6fThtZ4R+f4G+cTjqSO861exIzUvqag2gxl
	 wGG+RwEqDzxCw==
Date: Wed, 3 Dec 2025 10:02:21 -0800
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] lkdtm/bugs: Add cases for BUG and PANIC occurring in
 hardirq context
Message-ID: <202512030959.87E62F908@keescook>
References: <20251112175316.2841017-4-ardb+git@google.com>
 <20251112175316.2841017-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112175316.2841017-5-ardb+git@google.com>

On Wed, Nov 12, 2025 at 06:53:18PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Add lkdtm cases to trigger a BUG() or panic() from hardirq context. This
> is useful for testing pstore behavior being invoked from such contexts.

Sorry I lost this! Thanks for the offline ping. :)

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/misc/lkdtm/bugs.c | 53 ++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 376047beea3d..fa05d77acb55 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -8,6 +8,7 @@
>  #include "lkdtm.h"
>  #include <linux/cpu.h>
>  #include <linux/list.h>
> +#include <linux/hrtimer.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task_stack.h>
> @@ -100,11 +101,61 @@ static void lkdtm_PANIC_STOP_IRQOFF(void)
>  	stop_machine(panic_stop_irqoff_fn, &v, cpu_online_mask);
>  }
>  
> +static bool wait_for_panic;
> +
> +static enum hrtimer_restart panic_in_hardirq(struct hrtimer *timer)
> +{
> +	panic("from hard IRQ context");
> +
> +	wait_for_panic = false;
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void lkdtm_PANIC_IN_HARDIRQ(void)
> +{
> +	struct hrtimer timer;
> +
> +	wait_for_panic = true;
> +	hrtimer_setup_on_stack(&timer, panic_in_hardirq,
> +			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> +	hrtimer_start(&timer, us_to_ktime(100), HRTIMER_MODE_REL_HARD);
> +
> +	while (wait_for_panic)
> +		;
> +
> +	hrtimer_cancel(&timer);
> +}
> +
>  static void lkdtm_BUG(void)
>  {
>  	BUG();
>  }
>  
> +static bool wait_for_bug;
> +
> +static enum hrtimer_restart bug_in_hardirq(struct hrtimer *timer)
> +{
> +	BUG();
> +
> +	wait_for_bug = false;
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void lkdtm_BUG_IN_HARDIRQ(void)
> +{
> +	struct hrtimer timer;
> +
> +	wait_for_bug = true;
> +	hrtimer_setup_on_stack(&timer, bug_in_hardirq,
> +			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> +	hrtimer_start(&timer, us_to_ktime(100), HRTIMER_MODE_REL_HARD);
> +
> +	while (wait_for_bug)
> +		;
> +
> +	hrtimer_cancel(&timer);
> +}
> +
>  static int warn_counter;
>  
>  static void lkdtm_WARNING(void)
> @@ -696,7 +747,9 @@ static noinline void lkdtm_CORRUPT_PAC(void)
>  static struct crashtype crashtypes[] = {
>  	CRASHTYPE(PANIC),
>  	CRASHTYPE(PANIC_STOP_IRQOFF),
> +	CRASHTYPE(PANIC_IN_HARDIRQ),
>  	CRASHTYPE(BUG),
> +	CRASHTYPE(BUG_IN_HARDIRQ),
>  	CRASHTYPE(WARNING),
>  	CRASHTYPE(WARNING_MESSAGE),
>  	CRASHTYPE(EXCEPTION),

This all looks good to me. I always ask that new tests also get added to
the lkdtm selftest runner list in tools/testing/selftests/lkdtm/tests.txt

IIUC, bug in hardirq will result in a panic, so both these tests will
take out the entire system, so they should be skipped for the selftest.
Perhaps:


diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index cff124c1eddd..67cd53715d93 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -1,6 +1,8 @@
 #PANIC
 #PANIC_STOP_IRQOFF Crashes entire system
+#PANIC_IN_HARDIRQ Crashes entire system
 BUG kernel BUG at
+#BUG_IN_HARDIRQ Crashes entire system
 WARNING WARNING:
 WARNING_MESSAGE message trigger
 EXCEPTION




-- 
Kees Cook

