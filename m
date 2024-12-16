Return-Path: <linux-efi+bounces-2381-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CCD9F277F
	for <lists+linux-efi@lfdr.de>; Mon, 16 Dec 2024 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6950164D59
	for <lists+linux-efi@lfdr.de>; Mon, 16 Dec 2024 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110A4C79;
	Mon, 16 Dec 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF7unOvf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAB4A35
	for <linux-efi@vger.kernel.org>; Mon, 16 Dec 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734307997; cv=none; b=Zn5c74aJKXbpwBAYejuHoXyQdcES4zqIdWMx4H32NDp1gOq7dn3wnsrJdeiTUZFlBLVQYeF2lULI+iVi+ypVLOwX23eGm7f58Olg5emiEaqy2yElpGfs/4HGWhnBIEfvte6YjUU3byaIaVkx+4TZZLgc5EVPSM16+Ktaarz/syo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734307997; c=relaxed/simple;
	bh=utDrwxE2RTNWxcK3MaacgMKa7sXQWpDdAwdQB20Uf+U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pjUikTTOZIcIra8Rz7GlIXc4yHnV32l4DCP43lhEyK+NCJCtuVZU3RpU4WaXHro5yMlN+Sfjb7WfUd9lpwD0E7X76jrQPcPt2dDy5twJ5azG9MPn5gS8JJDFSTxrndM7GONhBhBxiwHk3B3eHAj9vFJ/yxvrEHVNDyETQXq/QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF7unOvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E07FC4CECE;
	Mon, 16 Dec 2024 00:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734307997;
	bh=utDrwxE2RTNWxcK3MaacgMKa7sXQWpDdAwdQB20Uf+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aF7unOvfjnsemC5fu432ABTeIHM5I5ZBD7ABsfEnvp9upDLBOmaCP+GQCfnN2ztSa
	 OkDILEAoUQs/Drgklnp3cCVYm9Q3wyaEjfgmdr9ptsOu7zVYl5oRnsVCzPwN8zzLdY
	 /Q/HIpQXRMaktsLmMPyA4vhPMtbRoELuo8UDMb6KlnZYfIuyXjPvLZ3xjPhjkRAjK4
	 gdIYG2DfAFVEJsCW9i9mZtDS25bG7Q6HTkc7hWS9tRG0MT1QL9Ds6kfGvkyCJc0C/L
	 9w9kb6upsz1o89Iy9zcGRqr14f2LvvKHTfZ+I75y318bht/DcihKQEugpHm8z9XVfL
	 Q5uqCRVQfCPOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714AC3806656;
	Mon, 16 Dec 2024 00:13:35 +0000 (UTC)
Subject: Re: [GIT PULL] First batch of EFI fixes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241215135047.8749-2-ardb+git@google.com>
References: <20241215135047.8749-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241215135047.8749-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.13-1
X-PR-Tracked-Commit-Id: 145ac100b63732291c0612528444d7f5ab593fb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7031a38ab74cfe997d2a767d18e3af7445547d07
Message-Id: <173430801410.3608335.17762170656885793417.pr-tracker-bot@kernel.org>
Date: Mon, 16 Dec 2024 00:13:34 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Dec 2024 14:50:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7031a38ab74cfe997d2a767d18e3af7445547d07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

