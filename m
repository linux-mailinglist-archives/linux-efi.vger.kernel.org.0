Return-Path: <linux-efi+bounces-1016-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0A8BB65B
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A184C1C229FE
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769554903;
	Fri,  3 May 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbnafAg3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EFD4CDE0
	for <linux-efi@vger.kernel.org>; Fri,  3 May 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772651; cv=none; b=H8J0Rw8N1m3/6FL5t1EiByhRoPbLI5CIszh8BfRNNxvsOCTKpmu5muQgklEenzZbQoAO3WRJ/f40DW6bhg4SahobJMSnMgsDE7a+ka4bSq5+HpHJAtkLhLzZA/0gNtkXjiuRCbCz6T7eN+lNMf/VvDXfLLsPOSdW6AsNcGTZNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772651; c=relaxed/simple;
	bh=Ei4kpBexTQ+5mC7ZtGoZPd1GMtHYHDFsUe3gxy/9+tM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SEbPsz12NnYx0UPAh8R5mCLxsL5ADObHApACCV9W8qMLGpDeAq86TdabxN9plrlsa75MUVW/Z+enM4Sex6dhyY5ylu4VIxz9FAqdyPpJIwowzKTY2omI+cJ75/12poiWiNFCTcESUw/+mb6eUVpAfiITKlRikIpDuGYe8BWX+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbnafAg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13F52C116B1;
	Fri,  3 May 2024 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714772651;
	bh=Ei4kpBexTQ+5mC7ZtGoZPd1GMtHYHDFsUe3gxy/9+tM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WbnafAg3TNEiM0vuAALKO/oXIpbWvqoInoO763F0JLTR5IVb23XnEr66SWlAWVioH
	 pJ272BIvBeq+vzZR//PdUw+na0Y1DBYkbDyYdFu3ehBjHWC0jlXx4JOyC7mwfif3IF
	 Kml5vfc6cGpXPWuBHYg8c2s7qqNRJJpFGqtcOEvf6hgsQ35i5dwjkO4liWocIIAM+k
	 LAiTbQdskpHFGhtfBZV2jS4Q7BXKQcSU1gs+1EfEq4cpToGYu3jVVqLgeA910rkVcA
	 gtTYxGNZLcegqGxEG7Abvx9z1kAwycqCq9RP45kkL0vGMlCef4KbOIUP+3OK50xYp9
	 gCZSBsoSsMsgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A588C433A2;
	Fri,  3 May 2024 21:44:11 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for v6.9 (#1)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240503110302.2339230-2-ardb+git@google.com>
References: <20240503110302.2339230-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240503110302.2339230-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.9-1
X-PR-Tracked-Commit-Id: 1c5a1627f48105cbab81d25ec2f72232bfaa8185
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f094ee78e01f5ee08d9489b4250fa1963fef81ab
Message-Id: <171477265103.28875.3657824653785531541.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 21:44:11 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 May 2024 13:03:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f094ee78e01f5ee08d9489b4250fa1963fef81ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

