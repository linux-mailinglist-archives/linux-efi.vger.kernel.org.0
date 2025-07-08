Return-Path: <linux-efi+bounces-4195-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8262AFCFE8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39C9189F322
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jul 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D72E0911;
	Tue,  8 Jul 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvL2OO/l"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE932DCC1C
	for <linux-efi@vger.kernel.org>; Tue,  8 Jul 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990387; cv=none; b=m+hO5vHCkFdGc8ruG3d3H8hr5tYoCHqn6mCMMM58o6lwKFRD3Jqx9Kb63yQsj/u3UgL7maFElyuEsldfJu/wOGw6T+YfWG/kSczAm7253CGqrV25YbzWle/a3ACDZryWINGBwNCIbKFy7pIpmQc4rtTWShX34ZvXwGpR4ixd+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990387; c=relaxed/simple;
	bh=PbymzuUJaIN8bXwKulxgMIzQ6Q+Uyj3QpqFjaSDMDi0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JrwlEB29Rw4iLdg3YA9D00AHbRBlyCOiO9rAdG7tVvgWbfKMJgPq09bPSUaO3liFJw0J52MnPXW0C7nzOFKnJiFTDczb2PgUZaY/iCeCXN8bwjPWTP7xtPPeFLdAmo3nllqSjakremC8tdCOo4mjfZ1ugT82cYQd7Dbpe06ZBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvL2OO/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4D4C4CEED;
	Tue,  8 Jul 2025 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990386;
	bh=PbymzuUJaIN8bXwKulxgMIzQ6Q+Uyj3QpqFjaSDMDi0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WvL2OO/lkQnZQTmfdgDIaLiLJjV/ObJQqgDqoVKHcNG7fQD0t2ziSXAFkk3TQl1Gj
	 OBhtqwGm/TWPjbDGMCwlJAzmFiYqsLx3RhJ+TyWfwfd/mk5Jwjo2nEuMBTnMuh7SgP
	 N647BsfSiSSpj3dFLfkDrtsIYeNVmx/T164TaUedZZEM1kMnkJgv3qhJEXu9JF92Oh
	 CZPA+O1RZnjsxwiCqeluTGCZB3LzjSUqOpeMU4sLdBklWsTuFk11bhZdsmOwSt7AtM
	 kgMgMWhaIkMnmomE/uJqESr6R0SeQ7Bb4LlUhQjJqiq77WhsR9wRxziBerrf70qNgp
	 mETt1OQW7xKvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECCB038111DD;
	Tue,  8 Jul 2025 16:00:10 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.16 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250708010153.1323761-2-ardb+git@google.com>
References: <20250708010153.1323761-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250708010153.1323761-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.16-1
X-PR-Tracked-Commit-Id: f8b53cc9174c5980549f60c972faad82b660b62d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eadb9fa7f775e39c2bdd9a43a947f03e86f9e37b
Message-Id: <175199041030.4117500.14244836199693530099.pr-tracker-bot@kernel.org>
Date: Tue, 08 Jul 2025 16:00:10 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  8 Jul 2025 03:01:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eadb9fa7f775e39c2bdd9a43a947f03e86f9e37b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

