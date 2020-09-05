Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812F725E4E5
	for <lists+linux-efi@lfdr.de>; Sat,  5 Sep 2020 03:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIEBbP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 21:31:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726456AbgIEBbP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 21:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599269474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=c4xOVGv6dzGHbs85EUGdfRfdzpWmagCZJlIPXPkfsX8=;
        b=ixzmQu2qo698TtkZFcbCEzOvK8HiTpomqNqNMc1iEwJlUvtrdt13I0NW2AcVIfXqAYpSRr
        nbG3U0J58JGIw15w9YfvdOW4e4Xr1TGONYfh6m9/I4FqEUXw0CwiiuZbSzTSFSeE41mm8v
        00i5emU1r7Zu9h8bvwZJZXErgbaTGw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-fc1BfPfoNOeiRs3-aDTr8g-1; Fri, 04 Sep 2020 21:31:10 -0400
X-MC-Unique: fc1BfPfoNOeiRs3-aDTr8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00453801ABB;
        Sat,  5 Sep 2020 01:31:09 +0000 (UTC)
Received: from lszubowi.redhat.com (ovpn-65-66.rdu2.redhat.com [10.10.65.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 819AA5D9CC;
        Sat,  5 Sep 2020 01:31:07 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        ardb@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, zohar@linux.ibm.com, bp@alien8.de,
        pjones@redhat.com, dhowells@redhat.com, prarit@redhat.com
Subject: [PATCH V2 0/3] integrity: Load certs from EFI MOK config table
Date:   Fri,  4 Sep 2020 21:31:04 -0400
Message-Id: <20200905013107.10457-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Because of system-specific EFI firmware limitations, EFI volatile
variables may not be capable of holding the required contents of
the Machine Owner Key (MOK) certificate store when the certificate
list grows above some size. Therefore, an EFI boot loader may pass
the MOK certs via a EFI configuration table created specifically for
this purpose to avoid this firmware limitation.

An EFI configuration table is a simpler and more robust mechanism
compared to EFI variables and is well suited for one-way passage
of static information from a pre-OS environment to the kernel.

Entries in the MOK variable configuration table are named key/value
pairs. Therefore the shim boot loader can create a MokListRT named
entry in the MOK configuration table that contains exactly the same
data as the MokListRT UEFI variable does or would otherwise contain.
As such, the kernel can load certs from the data in the MokListRT
configuration table entry data in the same way that it loads certs
from the data returned by the EFI GetVariable() runtime call for the
MokListRT variable.

This patch set does not remove the support for loading certs from the
EFI MOK variables into the platform key ring. However, if both the EFI
MOK configuration table and corresponding EFI MOK variables are present,
the MOK table is used as the source of MOK certs.

The contents of the individual named MOK config table entries are
made available to user space as individual sysfs binary files,
which are read-only to root, under:

	/sys/firmware/efi/mok-variables/

This enables an updated mokutil to provide support for:

	mokutil --list-enrolled

such that it can provide accurate information regardless of whether
the MOK configuration table or MOK EFI variables were the source
for certs. Note that all modifications of MOK related state are still
initiated by mokutil via EFI variables.

V2: Incorporate feedback from V1
  Patch 01: efi: Support for MOK variable config table
  - Minor update to change log; no code changes
  Patch 02: integrity: Move import of MokListRT certs to a separate routine
  - Clean up code flow in code moved to load_moklist_certs()
  - Remove some unnecessary initialization of variables
  Patch 03: integrity: Load certs from the EFI MOK config table
  - Update required due to changes in patch 02.
  - Remove unnecessary init of mokvar_entry in load_moklist_certs() 

V1:
  https://lore.kernel.org/lkml/20200826034455.28707-1-lszubowi@redhat.com/

Lenny Szubowicz (3):
  efi: Support for MOK variable config table
  integrity: Move import of MokListRT certs to a separate routine
  integrity: Load certs from the EFI MOK config table

 arch/x86/kernel/setup.c                       |   1 +
 arch/x86/platform/efi/efi.c                   |   3 +
 drivers/firmware/efi/Makefile                 |   1 +
 drivers/firmware/efi/arm-init.c               |   1 +
 drivers/firmware/efi/efi.c                    |   6 +
 drivers/firmware/efi/mokvar-table.c           | 360 ++++++++++++++++++
 include/linux/efi.h                           |  34 ++
 security/integrity/platform_certs/load_uefi.c |  85 ++++-
 8 files changed, 472 insertions(+), 19 deletions(-)
 create mode 100644 drivers/firmware/efi/mokvar-table.c

-- 
2.27.0

