Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66098267BAB
	for <lists+linux-efi@lfdr.de>; Sat, 12 Sep 2020 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgILRvK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Sep 2020 13:51:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33923 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgILRvI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Sep 2020 13:51:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id w186so13120768qkd.1
        for <linux-efi@vger.kernel.org>; Sat, 12 Sep 2020 10:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lq6sYZD0spXR3GRv5gzQudqNhiwrEh/zdZLHk7JB/no=;
        b=oo5Wm6LfJFnFabXGqEPh8WnC9gygMp3ttYh5osUqsNek6ppGZhbr+eqmXmZ5L/wLWk
         o0frMrudNLUM+EJ+BwPleRa+nrlUVmGLQ8NMGJOmPFxRuNIZ9tysFah+J15Wco9KbJlu
         ewf4DT3Bl9deCbmGmqPR/yGstZOipEjQNgHxZ5u0uCE2LRG9Xi2gYeSsVttCAI2tJqeb
         NGuihS15qnfooqYVwHQhym8bPthnB6zeo9YN+ojOLgxslvzqcG0VAKA7s7vTcYL9ZBQJ
         ggMqCruofoA38WsRaANCz0E7OG1IdoGAeaU504MFndou138S2pcZpzhpE35Zc8G2QHSR
         beMA==
X-Gm-Message-State: AOAM532mUk/kqS2nquWEoQnJ71ETVPdOZ7fovIiGzKzyrFc1L5WGYJ0E
        UUWLvTJk5VpRb/9OGnUV/+U=
X-Google-Smtp-Source: ABdhPJxBgCWyjhCeOl0sdmT0I+CoK0TfOckoisvCo32J9dzimn9cJ9Og+pOoE1lD+LTuI0bhQG+7rw==
X-Received: by 2002:a05:620a:2156:: with SMTP id m22mr6401538qkm.397.1599933067060;
        Sat, 12 Sep 2020 10:51:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h65sm7337352qtd.58.2020.09.12.10.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 10:51:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: [RFC PATCH 0/2] Quirk to handle Dell BIOS
Date:   Sat, 12 Sep 2020 13:51:03 -0400
Message-Id: <20200912175105.2085299-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I coded up the quirk to see what it looks like.

First patch is the quirk itself, and the second one is a slightly
rejiggered version of the dumping code for testing.

Jacobo, can you check if this fixes the efi stub boot?

Thanks.

Arvind Sankar (2):
  efi/x86: Add a quirk to support command line arguments on Dell EFI firmware
  efi/libstub: Dump command line before/after conversion

 .../firmware/efi/libstub/efi-stub-helper.c    | 139 +++++++++++++++++-
 drivers/firmware/efi/libstub/efistub.h        |  31 ++++
 drivers/firmware/efi/libstub/file.c           |   5 +-
 3 files changed, 173 insertions(+), 2 deletions(-)

-- 
2.26.2

