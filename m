Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE911338E
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 19:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfLDSRt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 13:17:49 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46853 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfLDSRs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 13:17:48 -0500
Received: by mail-qt1-f169.google.com with SMTP id 38so663768qtb.13
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 10:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/NtrK93kweHDh9fbynMFC36+nWCgNJ7iCqATo+lt4E=;
        b=fT5Vuam5fK2KgA+zMNSB/BTfrue178kGdvXS1w9W1gimet69ur0WMmz/NPhSKdPuxX
         wYwuRKx/E7tLrWEExPWEnQQVH2mMyJullhFz3y1dVl02CL7y05wXvG5GlT+Hvyz/SO00
         HXv9QWX9y5A1I6FO4BK7sOSg5UjWqafrqxLOhvUB+JgFpmf/jaiH9BQWG9SIzse93tOM
         D8p7OfQPB/FBWeW7K8Nyh8h3S4wOgv/W6ttFfWJcRwf1vsskG06CM8pIPcz1qtpMWop6
         fuio5oAHG9ztz0P27pQARHLsAcF/yEA/pjPxYCD+P+dfLaosvgXWH/DbesW/Sf8ypFlS
         qz1Q==
X-Gm-Message-State: APjAAAUo1vYR/xlLeqQwvQo9aUtJ6HhNCpmExcVhshhBgvMvYQy4ifIt
        KSgRUznoL58FrGAb14DIDhc=
X-Google-Smtp-Source: APXvYqypMZWQwPwtCAmQL3iVnY8bBBuS1F/nsarwUqqBaaWOlTFDaZLT8ZVxV4PjkD1fuehXQmpDXA==
X-Received: by 2002:aed:204d:: with SMTP id 71mr4136095qta.116.1575483466349;
        Wed, 04 Dec 2019 10:17:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c6sm4072506qka.111.2019.12.04.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:17:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH v2 0/3] Fix a couple of bugs in efi/gop.c
Date:   Wed,  4 Dec 2019 13:17:41 -0500
Message-Id: <20191204181744.14326-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203214728.19264-1-nivedita@alum.mit.edu>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes from v1:
- Split return value patch into two as requested.
- Remove the __gop_query functions

Arvind Sankar (3):
  efi/gop: Return EFI_NOT_FOUND if there are no usable GOP's
  efi/gop: Return EFI_SUCCESS if a usable GOP was found
  efi/gop: Fix memory leak from __gop_query32/64

 drivers/firmware/efi/libstub/gop.c | 76 +++++++-----------------------
 1 file changed, 17 insertions(+), 59 deletions(-)

-- 
2.23.0

