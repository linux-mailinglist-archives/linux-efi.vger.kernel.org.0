Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87B4441625
	for <lists+linux-efi@lfdr.de>; Mon,  1 Nov 2021 10:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhKAJWu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 05:22:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37914 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhKAJWH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Nov 2021 05:22:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 099301FD6C;
        Mon,  1 Nov 2021 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635758373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IfMfQon1WRlOFatpVNEVVz0ZISffpW/0UytWrwJq5sM=;
        b=NRCEF6Im4DFnpzCTKEk4F4qzSIsHJuMt1PCLdOiR/BlvV5Eu/fj4jGsI/h6lzMwGxhXSsh
        bOaOZAKFWGi/LKfezqWKvazdcfZA/lL/Q/B2E7GG1FaCjAbS0weYMe8aqcL3/3wBuAVEf+
        yzoOWZFqciF8ZmmNKivkhGCoyJudOao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635758373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IfMfQon1WRlOFatpVNEVVz0ZISffpW/0UytWrwJq5sM=;
        b=8rj/uY62Xgq8OUqyrR19Tl/PebvEE7wr+XTXEYmCzilA6V5rKjYInYxx1kUKrQp7zD/tim
        oFQi0ZGKRApiPTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E928213AB7;
        Mon,  1 Nov 2021 09:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tyDBOCSxf2HrNAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 09:19:32 +0000
Date:   Mon, 1 Nov 2021 10:19:29 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EFI updates for v5.16
Message-ID: <YX+xIaS0R2F9HJwr@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

please pull the last EFI pull request which is forwarded through the tip
tree, for v5.16. From now on, Ard will be sending stuff directly to you,
as already stated in the previous urgent pull.

Thx.

---

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-next-for-v5.16

for you to fetch changes up to 720dff78de360ad9742d5f438101cedcdb5dad84:

  efi: Allow efi=runtime (2021-09-28 22:44:15 +0200)

----------------------------------------------------------------
EFI update for v5.16

Disable EFI runtime services by default on PREEMPT_RT, while adding the
ability to re-enable them on demand by passing efi=runtime on the
command line.

----------------------------------------------------------------
Sebastian Andrzej Siewior (2):
      efi: Disable runtime services on RT
      efi: Allow efi=runtime

 drivers/firmware/efi/efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
