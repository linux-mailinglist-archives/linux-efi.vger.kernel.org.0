Return-Path: <linux-efi+bounces-6191-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMIFKBffl2nW9gIAu9opvQ
	(envelope-from <linux-efi+bounces-6191-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 05:12:07 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 024551648E1
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 05:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA7D03017790
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 04:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E730C618;
	Fri, 20 Feb 2026 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlSJ+SBe"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EC2F531F;
	Fri, 20 Feb 2026 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560638; cv=none; b=UV6QMMmDcmxBNwmecy7y2pV4WKybOlnpJgdzdpaebmyqyzZFu9O15b2gYKWHlXA+0c9gg0w+T9Py8ytyKKm9cfG/08wGY1XJp9sahFtoaS6PMp6HSryznAvSCKcD9lpyRnQdmtaFquMuuugoaxGI/XRh3J4IkVlxgxgRX7rGRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560638; c=relaxed/simple;
	bh=GmIn9ZeGRzlEikXjbn7PLITSKNkbNMHLY/Yf0fqF/IU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k761jAF1F8YlMD+HCDhnCPHkFhFZISAAKgZi8fjFqHLJhcpV6aya1cY/m6tWF9DAXcQ4O4vfu67dSb2HOVCWFSyhYg0lXUbr62rwxuz6I1Fwtev5Kw8vwNbP5xFaZhaCQHrAeSrVEAwzfTLIoZuBNb0CI3UZKSj8lw+Utx+KAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlSJ+SBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2047BC116D0;
	Fri, 20 Feb 2026 04:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560638;
	bh=GmIn9ZeGRzlEikXjbn7PLITSKNkbNMHLY/Yf0fqF/IU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VlSJ+SBeeAPfhnON1ZyXqzphBgx4V3bgTvauvu85YeiI5mlTREBkb61m+04o3wIWh
	 6Pno9LXCnhI8nC/hRuhMd+fgshIq0F1mAH/DEcZO4aKOqExOeYtnuKxBzsIJIvpQze
	 kdL6hhYvFuStENEHeFVIsSx0Au5ENsZWIX8atJWOiOnN2444grbOsGlgPysnVsmu9E
	 V8116kPklhvS6giKFOfwBSN9DJyoDX0edjy80ThUYXR7VyxfB9IkYX0z/CHc2Wnpsg
	 m5FnCTC63lZ+rp27A0NoXGnjEIsJQjZpptu6p3QNXtBcuAzBXZ7aD+CXrcMpktT189
	 t7CzKaZ1g1AUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD93809A88;
	Fri, 20 Feb 2026 04:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/9] arch,sysfb,efi: Support EDID on non-x86 EFI
 systems
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156064628.189817.770597310770698604.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:46 +0000
References: <20251126160854.553077-1-tzimmermann@suse.de>
In-Reply-To: <20251126160854.553077-1-tzimmermann@suse.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-riscv@lists.infradead.org, ardb@kernel.org, javierm@redhat.com,
 arnd@arndb.de, richard.lyu@suse.com, helgaas@kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6191-lists,linux-efi=lfdr.de,linux-riscv];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-efi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 024551648E1
X-Rspamd-Action: no action

Hello:

This series was applied to riscv/linux.git (fixes)
by Ard Biesheuvel <ardb@kernel.org>:

On Wed, 26 Nov 2025 17:03:17 +0100 you wrote:
> Replace screen_info and edid_info with sysfb_primary_device of type
> struct sysfb_display_info. Update all users. Then implement EDID support
> in the kernel EFI code.
> 
> Sysfb DRM drivers currently fetch the global edid_info directly, when
> they should get that information together with the screen_info from their
> device. Wrapping screen_info and edid_info in sysfb_primary_display and
> passing this to drivers enables this.
> 
> [...]

Here is the summary with links:
  - [v3,1/9] efi: earlycon: Reduce number of references to global screen_info
    https://git.kernel.org/riscv/c/b868070fbc02
  - [v3,2/9] efi: sysfb_efi: Reduce number of references to global screen_info
    (no matching commit)
  - [v3,3/9] sysfb: Add struct sysfb_display_info
    https://git.kernel.org/riscv/c/b945922619b7
  - [v3,4/9] sysfb: Replace screen_info with sysfb_primary_display
    (no matching commit)
  - [v3,5/9] sysfb: Pass sysfb_primary_display to devices
    https://git.kernel.org/riscv/c/08e583ad6857
  - [v3,6/9] sysfb: Move edid_info into sysfb_primary_display
    https://git.kernel.org/riscv/c/4fcae6358871
  - [v3,7/9] efi: Refactor init_primary_display() helpers
    (no matching commit)
  - [v3,8/9] efi: Support EDID information
    (no matching commit)
  - [v3,9/9] efi: libstub: Simplify interfaces for primary_display
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



