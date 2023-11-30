Return-Path: <linux-efi+bounces-106-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75307FFF65
	for <lists+linux-efi@lfdr.de>; Fri,  1 Dec 2023 00:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E4281964
	for <lists+linux-efi@lfdr.de>; Thu, 30 Nov 2023 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A55952F;
	Thu, 30 Nov 2023 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4qKu31x"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5E5952E
	for <linux-efi@vger.kernel.org>; Thu, 30 Nov 2023 23:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D0E3C433CD;
	Thu, 30 Nov 2023 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701386677;
	bh=Iwktb8/YBkZ+hxkQDHQozxwHK0v9nar/H9+b8z2Gvdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D4qKu31x35xt2VVf61vrXcnvU/C8hPBNBXQGy/Fdis0pgOpwiOmVRIbSb6Uy1qu4I
	 eWk0PiiH2lSS6Rzxc9e57t8Z/bBzhXZA4HJxKM/PGlW+0DyNIz9T7x8pjAvqhv8KI5
	 sR75n9MnThveTqdmkkeDqcnsDho7C9q1g2RAYacHbxg3RhnIJH4P2a31yvpHNUoteS
	 vcUiX1qVAByGB3U86Ejwqc6RkYmGT7vPTVu2cTJT3v98by7QhrFQ1GsVsDkwmHeG2S
	 cxPthXYun7QS9DlqSyPgYLjeqt1Zplss8BkYt8FQx4aqpIt0ntUdg5bnbTwUCQFHK3
	 EJAfVsymcVaQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64F68DFAA82;
	Thu, 30 Nov 2023 23:24:37 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for v6.7 (#1)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231130095718.3985492-2-ardb@google.com>
References: <20231130095718.3985492-2-ardb@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130095718.3985492-2-ardb@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-1
X-PR-Tracked-Commit-Id: 01b1e3ca0e5ce47bbae8217d47376ad01b331b07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d3eac3c05ffb4e56cece2e7c4cc7fa2f1188748
Message-Id: <170138667740.16887.16937398408562929485.pr-tracker-bot@kernel.org>
Date: Thu, 30 Nov 2023 23:24:37 +0000
To: Ard Biesheuvel <ardb@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Nov 2023 10:57:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d3eac3c05ffb4e56cece2e7c4cc7fa2f1188748

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

