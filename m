Return-Path: <linux-efi+bounces-6108-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tWqWEym+imneNQAAu9opvQ
	(envelope-from <linux-efi+bounces-6108-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 10 Feb 2026 06:12:09 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE811700D
	for <lists+linux-efi@lfdr.de>; Tue, 10 Feb 2026 06:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2493307A3BE
	for <lists+linux-efi@lfdr.de>; Tue, 10 Feb 2026 05:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF60329C79;
	Tue, 10 Feb 2026 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V//WIiz0"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8619CC14
	for <linux-efi@vger.kernel.org>; Tue, 10 Feb 2026 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700137; cv=none; b=IunimP1p6LWc0fqD5RI1IpgGomkyGmFavzniy9hkxX1hgnQ2KIhj7i88VsIoz0WBoeZrn0iUdEbk1fpnde73eq/p46xblhASzUTRmzAiZAAespkn0xHQJ7VA4z2GvkN331LRBD8G173V2ky3yD7VE3L2FdT6MbeWqdBtiylGds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700137; c=relaxed/simple;
	bh=pr7eS5QHoVHbUwRNJqyn4qNm/qMQX6zDgV9GywLNBBI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dc90hxyR4j2ekf6e80MaQk8DMN4RhjpI8LN59PBM4ML8ypFMQ75jTgkdQXOKnD9m8uUr+NDtkCx6eNu17NY6x7KINMZxjWNYLrPe/oz6YBOYznCEaLA24/1fJDmrZsTm37opPnZKqFlU3dthUVuoBWoP3f0IBebDf8JNr4j7Sx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V//WIiz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8233FC116C6;
	Tue, 10 Feb 2026 05:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770700137;
	bh=pr7eS5QHoVHbUwRNJqyn4qNm/qMQX6zDgV9GywLNBBI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V//WIiz0Sn83+bKFv51PjscAyccGX4Zr0awx+ANKFENZDq0QGcJ5I7Oae+xzvbjqV
	 D9rWpvIHnbF7Fh1hLztTv2zY6g7TEhTqQS4HlVIhrMjBhfaDuhUkaF2K9rJu2K/o5i
	 Q50mxrQNCJ8iHMxzEvLCWDDp4JitI8NJ/fSGczfugnwlkDbo4BNUAchvPe8kCtD0vg
	 tdrBhilTpNtCBHbozzvD9UEVwD04WSfbwaQCQUD54RIYjJ7c6zfjPF3P9YDj57wf6k
	 elGzJO9NUwSHCZU+N3VSkn4p5n59rDI73/YmXazTDEXShb5aeFi8jWirczB4I4Oieb
	 vx1iA0lhtFokw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481BB380AA5E;
	Tue, 10 Feb 2026 05:08:54 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209184805.556296-1-ardb@kernel.org>
References: <20260209184805.556296-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260209184805.556296-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v7.0
X-PR-Tracked-Commit-Id: c5a8f13f1e476c90f4bc184a58751d3e7ff88f2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c61526621ec1916527d6f6226d8a466340cca22
Message-Id: <177070013277.3352335.14257238404022289226.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 05:08:52 +0000
To: Ard Biesheuvel <ardb@kernel.org>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6108-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-efi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEDE811700D
X-Rspamd-Action: no action

The pull request you sent on Mon,  9 Feb 2026 19:48:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c61526621ec1916527d6f6226d8a466340cca22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

