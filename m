Return-Path: <linux-efi+bounces-677-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46286EA27
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 21:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609E01F24B8F
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D53C484;
	Fri,  1 Mar 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmbTvPwd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF43C47A
	for <linux-efi@vger.kernel.org>; Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324241; cv=none; b=dxoYvYU4E6GLqglESakeyXQ6x5FrIdsHBryys40CkujioglfKe1ry9ocLf+CvjZV3AqXiD6a7ap8S9fHPVyzSgUbkulRFVvw9FmrhqZU3ZrnUATtAmoKHtPtoMVUyIEBfipJOTkpTjziGxWvv7wXNNp4n1EwJiGHVka7SkHysyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324241; c=relaxed/simple;
	bh=7vD66QVt2bViW5tluteJbGnU7KANp0Yy0en6nS3V/vM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YInrDf5bBMSEP5QO3XqG5bCHum6Z1RC3grw/eJ46D/OSoX3j2B8Sc+6mzfInCYMv/TeAihRTloJ6V42oZeGW2b3AsKNPuY2u2qBh5MMyVtVesMmCmZAMmik8EgaojcveeLpeA1nDqiZ7vXDX0otSywr4pwHeWoniD/nu0cnYgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmbTvPwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F7FCC433F1;
	Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709324240;
	bh=7vD66QVt2bViW5tluteJbGnU7KANp0Yy0en6nS3V/vM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hmbTvPwdGgwNznoRsKQ2BoBfS+HU0Gg7RA6O6GWvuRHFpPyf4sejHA7y4eVatucdi
	 V6nVU+PwniB/6udjbD7f9rNJ8dh+1cXM4vAQwzAP9uOqSeM1X6bi8yJPhzBX/pnmA8
	 rdmOf1J58ugPMPkM1eAuwzyJu7mtQr9WgbjgZIU4EJtGRxgumc8gQ9yQYbsNXlGOTM
	 sdsJlZoRkH/9Zy7Kq+Y1dsZUBW/d+bJX+ABZK+a/BDIX2Ox22l9KRsrnuc66yr2j5G
	 dcryp00XciXiqsmDzKuxolwAvuHioDyer6l+cp6Zg5SbPMa2DQIiHXBdTgGicEmitR
	 NVxj/xLGPv9LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F86AC595C4;
	Fri,  1 Mar 2024 20:17:20 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.8 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240301095126.1223559-2-ardb+git@google.com>
References: <20240301095126.1223559-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240301095126.1223559-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.8-2
X-PR-Tracked-Commit-Id: 2ce507f57ba9c78c080d4a050ebdc97263239de8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bbb54ba1bf73d0f7db0d218731db721199e0db0
Message-Id: <170932424044.25962.17134990786497483301.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:17:20 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Mar 2024 10:51:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bbb54ba1bf73d0f7db0d218731db721199e0db0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

