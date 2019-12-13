Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96C11E041
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfLMJHC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Dec 2019 04:07:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36496 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfLMJHC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 04:07:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so5797933wru.3;
        Fri, 13 Dec 2019 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zgE7H652OqyN4nqOaV860HJ7ZzQUNg5TLy0QsJ2RWEM=;
        b=J1oVLkla8WreiTlDRa8LXhCUU3+ujH95oXC6BB78EC0TlSd6fLuE2GRl+0xU9wkgF/
         pyiyXOPC1BtTsJaHcINVAVDo++Wm383E4Q9i5piBTTXn49Pj2ALqb7sMcSUNkIbfT+yS
         K41HTu/Fh6XO7jD1+BHEfutnY8DvE7/4h4QCqP/EGosQaxJRTuErqsXGNXZaIUKlgS/M
         ttQvUX5dQv/Dn31A6dLorPNkKNvVw5Xm93i3BrnH0CEukc26UZp3qzPUX9Hafr0dM8Qn
         zwGBiZvLc/9JryUUTIAfiKJy58fNZtfm5fGzi2nfQ8YT7b2vnHRrELju7cV9nRB0jdkh
         dpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zgE7H652OqyN4nqOaV860HJ7ZzQUNg5TLy0QsJ2RWEM=;
        b=jZIOmZtAsEKd7kimOxV0IrEYPz/QqRV1JYPzJNLd7iHHnP2DFHN3zZyAArxDGnlZ50
         EdUuMVoBfyqLA2sX/7jKf/PEfVbjtbgdLO8eWzJW8P0H8yWRDkAHUbMevnSReTmGtVQa
         hszGdgyairpDkCY+r7eQvtsOuZsz5APwAdPZ1DRtNNPJNfNBRDnPsHfu8YvIMJDZW3FZ
         9Ze8bQK0anUjYogz4GRKsFa7KVDIaqYTjIAOasL7PpfXn5oD032hEDlp/jZjbESa2c55
         YuiOGJ2FUM93UKz1BgAUzTerrsvCUrRG0J01Q9jm+q9SPVA2iVrIHTJO8riFPv6rdwHA
         y58Q==
X-Gm-Message-State: APjAAAU4nNoysGG4j54NdB9MLCNxPAlLmk5DJsSi8VvP5QDh68ZkZdL7
        XJbEhYsZvi7bSCdvncVvAtQ=
X-Google-Smtp-Source: APXvYqwctuSRjAyVEEe/pDJj7009/7T6jQBFBpEvZyv0JWbqyBLun6a0bGKtliRCpDHSmpSNK3YUkA==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr11423586wrn.75.1576228019639;
        Fri, 13 Dec 2019 01:06:59 -0800 (PST)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id y6sm9079094wrl.17.2019.12.13.01.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 01:06:58 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 0/2 v2] efi: cosmetic patches for the error messages when
Date:   Fri, 13 Dec 2019 17:06:44 +0800
Message-Id: <20191213090646.12329-1-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When loading certificates list from EFI variables, the error
messages and efi status codes always be emitted to dmesg. It looks
ugly:

[    2.335031] Couldn't get size: 0x800000000000000e
[    2.335032] Couldn't get UEFI MokListRT 
[    2.339985] Couldn't get size: 0x800000000000000e
[    2.339987] Couldn't get UEFI dbx list

This cosmetic patch set moved the above messages to the error
handling code path. And, it adds a function to convert EFI status
code to a string for improving the readability of debug log. The function
can also be used in other EFI logs.

v2:
The convert function be moved to efi.c

Lee, Chun-Yi (2):
  efi: add a function to convert the status code to a string
  efi: show error messages only when loading certificates is failed

 drivers/firmware/efi/efi.c                    | 32 +++++++++++++++++++++
 include/linux/efi.h                           |  1 +
 security/integrity/platform_certs/load_uefi.c | 41 ++++++++++++++-------------
 3 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.16.4

