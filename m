Return-Path: <linux-efi+bounces-147-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076A880A964
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B682F2818B6
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10D38DEC;
	Fri,  8 Dec 2023 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbHxaSoS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5876C19A4
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 08:39:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c941936f7fso14574267b3.0
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702053572; x=1702658372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HcPWgxq5wP5HDT3HOjbVp2OIWRp2UjSl+DNyEGOk0r4=;
        b=GbHxaSoS83BUu7re9LY0zqPpYuXpCjyOaOlZX/lHraO4BP4+lQxPeLkRWmjI//kuc7
         25ZPiFuc0WPIbP/2yPW5J5jht5ND5KIXN0XXZ493St51xcfPrQnzqQqmTonggYzXl+m4
         wgo+1rF+iylNE6L7luf+gXNBz+I+Ss7BIdqmhI+94ntQ1CqadYm/EveQLl79SqpP6lz8
         2nQhXOOOFbTu4hltfjwH68wzZId/jv7EsaT4e/XIHDJJCsh/2zgpJIZqRfO0NtwBJgFZ
         KjjITfBKdunhBulCHyy3sZYFWxsNv1xN0kL6vDe7r4iugY6DXGR2MYY3Nl5EIKq1A3Yz
         asoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053572; x=1702658372;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcPWgxq5wP5HDT3HOjbVp2OIWRp2UjSl+DNyEGOk0r4=;
        b=swfY2Wf+UXEwfTD3eDDMLPjvSCLvuKAnBux4RvfUsJZYFyOzeviYzBXTar0JlgKonU
         o8mv3UWskLKPOi/zMoZQvRbnIjnm+G2LanHToUlstqVtGZKwF0HyaZZSEyb2ZeBEbQG4
         yQrbd0tJlsGs/UHZX/YI+sqccxfcZNnADwdsUZGy3De6+81qwdgDyQwOj/b84FA6n5ew
         Xa1SG4NjixJMrpCEO+eG5z9fken6vg0HSc88DHrw+MzdHQsGTNIoKRy4kGsILa1UfqU0
         sINrzZ8i3HLEaSCr7JuV4jJQ5UNumrzyFX4ceHpPjBRbWvTng8lhdpENwJ0SDmAcBwc4
         c8Vg==
X-Gm-Message-State: AOJu0YyRcPndwpwbFFFjiW3RsvNqgHYaDZGxJGimGmLatSa0uQNVqHmJ
	WFttHW2sew2WaYihjXfBhNro6hm2r19nZ1FZOJ+4rIFFui0BlMmQTUcpxb6MdksKWvHsbVjyW/f
	mWL8Ogp3HxeHL//FWzjk8LOR+6+P/2GYHX/87BUWMuJVqhiSWbYc3HRoen2wR
X-Google-Smtp-Source: AGHT+IF+hdOnJk2VSjru1XU1KIgjRSM93On6qbvv/IxqpnLeesvCaVztbOmBs2mV/a7WdGkvPv96WSh3
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:3586:b0:5d3:d44a:578d with SMTP id
 fr6-20020a05690c358600b005d3d44a578dmr8822ywb.4.1702053572252; Fri, 08 Dec
 2023 08:39:32 -0800 (PST)
Date: Fri,  8 Dec 2023 17:39:26 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=618; i=ardb@kernel.org;
 h=from:subject; bh=ke/yFxbldPNDyYM47CjVDl/I+SZeyeQnOAvlYydKwAA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIbXYbZ/TP68gZ6e2xrMljq/zzh57verVy5ORd3teLHPcb
 PLnS21bRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIEhlGhr/VSVICGcLzeRca
 pASvXipw+pnPxjD97Proi4bLXNR0ZzP8lTTOqYhdeeJKFmPXrjt3v3PsY30qe0BoQ11phc9TL+M EPgA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208163925.3225018-5-ardb@google.com>
Subject: [PATCH 0/3] efivarfs fixes
From: Ard Biesheuvel <ardb@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Jiao Zhou <jiaozhou@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Some fixes for efivarfs, most notably, a fix in patch #3 for a long
standing issue reported by syzbot.

Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiao Zhou <jiaozhou@google.com>

Ard Biesheuvel (3):
  efivarfs: Move efivar availability check into FS context init
  efivarfs: Free s_fs_info on unmount
  efivarfs: Move efivarfs list into superblock s_fs_info

 fs/efivarfs/inode.c    |  3 +-
 fs/efivarfs/internal.h |  6 ++--
 fs/efivarfs/super.c    | 31 ++++++++++----------
 fs/efivarfs/vars.c     |  5 ++--
 4 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


