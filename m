Return-Path: <linux-efi+bounces-5814-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8ECA9D52
	for <lists+linux-efi@lfdr.de>; Sat, 06 Dec 2025 02:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BC313015102
	for <lists+linux-efi@lfdr.de>; Sat,  6 Dec 2025 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245A831282F;
	Sat,  6 Dec 2025 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFGGa8Nf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686131281B;
	Sat,  6 Dec 2025 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980372; cv=none; b=eREgAJ4cbrkOogANfV1Yl/20Fh+IKaOJjUMCrz1uR2it4t4rc8KKYw8+UqrgFyG5T3KROlbwDDeSDOl4dJ6+dfUqUHnhTBcPJR79P/g93ufi6uVVYOTyEAgriO1gwV1W6B6xVsatwPThgkjhFtfDBDVR4YI6CXr6fsYiCIi7R8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980372; c=relaxed/simple;
	bh=3etdHXSgtNYaEFUmgruCO24HTvt5AYTu0uxT7IBnUcQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FG00Dh3iClXHWdW0u06aUxDBMP8gFKGcA/HRiqNgTBOLMpC0umZGsTOCdxDvW8yLCvcpVeVDiwzre/epm07fiISVW/CLo4bkQOKBuGlWo53+M++g37bc140GQP9A9hsnIjB15spVkda7mvljMspwfnBOj68HeBvPsyJ41Ok6Wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFGGa8Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB73C116B1;
	Sat,  6 Dec 2025 00:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764980371;
	bh=3etdHXSgtNYaEFUmgruCO24HTvt5AYTu0uxT7IBnUcQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QFGGa8NfLjC1InBOhTibkDHpgzIfL1CyCFJJuoSLwER+CI30Z6Ed8kqDqBCysV0Ow
	 ehy3mpRaC13ofFn0ZG4feletaqBePnlDkOnJWCNnh68c4loysX12Xypo/W1ZEMXAxw
	 q0wpFI9fIj4hzKR/voXXAvOwhvfpo0I/avm4Gw+o2fIoRnoa39VjKSCD7EQ0C3fLbc
	 0Vt2S4hBsziFNDwEXtNS51+jaxWEqfTHFU05dehe1ccAHGdACJzgj51W0gDFkKX39B
	 bMkN4dJbRr1eR2j8m8Is4dCPR9GWlezVuBUMxUNC7IdnINovjJWwLfT4wfgrbyhARn
	 KUSUcgcnJgNKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0E6203808200;
	Sat,  6 Dec 2025 00:16:30 +0000 (UTC)
Subject: Re: [git pull][vfs] tree-in-dcache stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251204064706.GJ1712166@ZenIV>
References: <20251204064706.GJ1712166@ZenIV>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20251204064706.GJ1712166@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-persistency
X-PR-Tracked-Commit-Id: eb028c33451af08bb34f45c6be6967ef1c98cbd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cd122b55283d3ceef71a5b723ccaa03a72284b4
Message-Id: <176498018885.1869773.11235050751770031700.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 00:16:28 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>, NeilBrown <neil@brown.name>, Andreas Hindborg <a.hindborg@kernel.org>, linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, linuxppc-dev@lists.ozlabs.org, John Johansen <john.johansen@canonical.com>, selinux@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, Chris Mason <clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Dec 2025 06:47:06 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-persistency

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cd122b55283d3ceef71a5b723ccaa03a72284b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

