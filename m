Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24FE19673B
	for <lists+linux-efi@lfdr.de>; Sat, 28 Mar 2020 17:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1QGM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Mar 2020 12:06:12 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:44198 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1QGL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Mar 2020 12:06:11 -0400
Received: by mail-qk1-f172.google.com with SMTP id j4so14249568qkc.11
        for <linux-efi@vger.kernel.org>; Sat, 28 Mar 2020 09:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nx29lK5V9K1UVWqS04pYk1cm+2d5FeyHv9TtXGTH19E=;
        b=n+3mQz6bmriuKHW+GFK8wv8AZV4ievOrhLfd8+JQnXBWSeTTFBwMdcsMv1fR3F4Jz9
         t9L9s2MK0rEeEf+RXkdZS7YFcixkwUhNNiQ6jgOiN5xvVYdrHqQzzVMbg0W5WwyTNDQf
         UQ77iQvWEXIJhvv7fBlu1gMJAq+uYu8TeL+aa1902Au99XK3t44M59LImym6k0+jmFcU
         My7yHIurysEUhmO9ihqlYULVL9UgikuXE2XzKvr9b/3In9wpugJXjzN3JB8EpawAaVAS
         e4g9JpX7RiWj2fCjwujCGMxJ5RsP2kihtesFm4rfJA+UoTDUtUYRSC1snvmPaUeZ5tsU
         jY4g==
X-Gm-Message-State: ANhLgQ0HhAlpTlBAYky6rViyzYqjDQGIAY0NA7FqgjVCSZvEiLUwwgis
        nF6TpbNXhZMHRt7shjYAkfY=
X-Google-Smtp-Source: ADFU+vsnk5SpmEXLyP9bWNivQhXNxHhHvjsxMzd9W+IqqUmqlKMZNgV/NgPo6ya98lWcxPP7SP1VxQ==
X-Received: by 2002:a37:a40e:: with SMTP id n14mr4546269qke.494.1585411570933;
        Sat, 28 Mar 2020 09:06:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n142sm6115695qkn.11.2020.03.28.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 09:06:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: efi/gop: skip cur_mode in choose_mode_auto
Date:   Sat, 28 Mar 2020 12:06:00 -0400
Message-Id: <20200328160601.378299-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAMj1kXFBB4RmokpM7nqm3jPQofDhfC89QuEurz6OwNPureVK8g@mail.gmail.com>
References: <CAMj1kXFBB4RmokpM7nqm3jPQofDhfC89QuEurz6OwNPureVK8g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard, can you replace the previous version with v3? I skipped calling
query_mode for cur_mode in choose_mode_res but forgot to do it for
choose_mode_auto.

Thanks.


