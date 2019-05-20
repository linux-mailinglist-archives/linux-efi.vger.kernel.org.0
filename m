Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05A424256
	for <lists+linux-efi@lfdr.de>; Mon, 20 May 2019 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfETUzH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 May 2019 16:55:07 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49620 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETUzH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 May 2019 16:55:07 -0400
Received: by mail-qk1-f202.google.com with SMTP id c4so4102011qkd.16
        for <linux-efi@vger.kernel.org>; Mon, 20 May 2019 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=KwKcFS84Od+0uDcbkZwTpIrT43f2kU8zmORrILLiHk2F8YkNKiv1DApHnhAMtYlYNA
         TTKtXmA8TJ8/ipv7ecH3TyAPVRf9bZ8GXZEFmFgwDXPD4Hjtc9OoZlG6aBmwZtYTn8Oc
         Nvt9VJVKM4ko0egxxq7cUr2yFh5bt2A6FPsfeESlkTgj+tTo5HipWQkdt0PV7yGNpC2p
         qwWO/zif0wXn7M/9LQBi1kh21TF0FRSHZu9qfX+5MMJsj7woSz3xBh9gb5WkU4/0KX4c
         dnI+ZE7GgTCEi7VKzXkA1bmYAkK0Nv9eJ0xJyAJqd/DQAikMJoy/AIkKcuCOHk84b2v+
         el5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CEe51n1cJjGjM3r3jhy0lvCRaDr0xuP675ZqA1iPYL4=;
        b=A4wdFmFcgNcoFb14j6KNKHRp2JWuAzvlihTck7oj0CA+TdT+eGb3gL7S52YQ0xWOqk
         ZXOy7ONI37U1PxkZPsv6GWrUvvk905BFwu9MuDrhBBCcb3yfxsc3czcV21oA2DiQZyFY
         DudtGN6KfdSSfWpBJfBTDCWwpPh7TbBwKm+TtV2ea2crHXy9VL66MVEuM5cYwOSICDzF
         Z42u7OEl/uicmwSAQCVI1bgGq+Rgt6eroGDaqanPlm4uB8o3cfPuWKs4dh7pM8nScGN7
         +AMfTHndNJSs4qZe9F9PllUkRiZ5ho5rMTo7oP+gFpPQIG9eOBezuZmvzsNF8uQBESQu
         IQLA==
X-Gm-Message-State: APjAAAVxgV2WfaK5LRdttZ8OiB6qCq5oiq8GGlpTRi9aYRbjVVR/bLet
        G7WMRfVXTnM79Dt899Ea+nn685Iqtrxx6xq8tTXIvQ==
X-Google-Smtp-Source: APXvYqxcgPZwWQB2M99XR5b353YmJ/Ei17uYUIv35ZBhj13nsYbaZL7VC+EcLkbxPlvT59VqEEmZiqG52LG+K02tnRds4g==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr32298826qkl.243.1558385706056;
 Mon, 20 May 2019 13:55:06 -0700 (PDT)
Date:   Mon, 20 May 2019 13:54:57 -0700
Message-Id: <20190520205501.177637-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V7 0/4] Add support for crypto agile logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Identical to previous version except without the KSAN workaround - Ard
has a better solution for that.


