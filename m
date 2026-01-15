Return-Path: <linux-efi+bounces-6002-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A32D2858D
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 21:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824DF30BC940
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jan 2026 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E61322A3E;
	Thu, 15 Jan 2026 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcH0Fe9y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AD322A29
	for <linux-efi@vger.kernel.org>; Thu, 15 Jan 2026 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507997; cv=none; b=uwOt0VT0O+9FIlobSaU8uqPAoIKN8pfkepxoxX4/dRyQcx6DDdf7q5Dss0odLwe/RyEG7tnPM5MGCzOlgpxmae+/r/rkbchV/C+uhg2Jpwy6RkY5FAt6vVgTCtYWqDJsd94TN1z+8JWTHk2Mbn/YO8j4W46KYQmBoJ6c0mZUDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507997; c=relaxed/simple;
	bh=ZxBJKkBbTYPblMD1qB1XpJ5ST2+6RDF/vYhZY61iZ18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OZDSV/cEbeTi0IZVwZMU8XbQE3TZ7MQmqk3gGmSz037fS4ksc1z+M90Xfhf2mfIAmUMttjwthfDao9T29OVBZEkQbCXfEzo/hnURNcePauqfEvjwyRIqKrW4XfD6fMOeQWENHC5OMIL0t5woWP2SobMruezGKsZsBCzlozKA2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcH0Fe9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8863C116D0;
	Thu, 15 Jan 2026 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507996;
	bh=ZxBJKkBbTYPblMD1qB1XpJ5ST2+6RDF/vYhZY61iZ18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CcH0Fe9yJ8aomfxIZiOseroBKeR3dni7m7qcPnpwfReNQUucXt25fFo9cNevsl2D+
	 aMUJYRJ6b9KNKAFmQ6l8EBst9pJvABmqUTyn42gNBw/ljY8nrPvjeU3LtaI6QIPg86
	 VED/SU64G3drhY228x4WlmWlLug7ikHeVVkjK19VNf6z6FkyiOZe9klKQETG2CNcvx
	 Oy1orQHenwO39lFl8SUNIqNu2qtqtiNtwIhn2Kq71/TrqUUAocOnX9dLbtDAneIfqy
	 pET8bE3pzBgsLmCJ9WYyyfHRULfAzAkNMQZXvVkeelG+hCnRt4doB1imj34aLgxRr1
	 US56EYNfOeSZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B784380A97F;
	Thu, 15 Jan 2026 20:09:50 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.19 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260115172610.1844636-2-ardb+git@google.com>
References: <20260115172610.1844636-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260115172610.1844636-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-2
X-PR-Tracked-Commit-Id: d7f1b4bdc7108be1b178e1617b5f45c8918e88d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc08b6588037e8894bcdb940c3adbc4308387353
Message-Id: <176850778877.4151234.1548330644050301576.pr-tracker-bot@kernel.org>
Date: Thu, 15 Jan 2026 20:09:48 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Jan 2026 18:26:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc08b6588037e8894bcdb940c3adbc4308387353

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

