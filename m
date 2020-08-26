Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9A2525D8
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 05:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHZDpG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 23:45:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22771 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgHZDpG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Aug 2020 23:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598413505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=LT6POVV8HSmICCQ9Cr0CByMFS3SYARiZwXUJRkcEo+U=;
        b=efmbh3bcZVcfnEoG96S2vyrJSM+aqAF1O6DKiEZTgSHo+t0LdE4KL5euB8iO2+wwCMhZ71
        I62aFeCRPSlnEcDb34NXqm1rR7wP9/spXVAwKvEF6jW2vYR7kA87lIjOdnsjMOgEhZNtU2
        aKdqJbVnrOjz0a4sAjwlGfRGfLhw2EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-naIzhBe0MFmexAJKAilz9A-1; Tue, 25 Aug 2020 23:45:01 -0400
X-MC-Unique: naIzhBe0MFmexAJKAilz9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE3FA1005E5B;
        Wed, 26 Aug 2020 03:44:59 +0000 (UTC)
Received: from lszubowi.redhat.com (unknown [10.10.110.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1C7A5D9E4;
        Wed, 26 Aug 2020 03:44:56 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, ardb@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        zohar@linux.ibm.com, bp@alien8.de, pjones@redhat.com,
        dhowells@redhat.com, prarit@redhat.com
Subject: [PATCH 0/3] integrity: Load certs from EFI MOK config table
Date:   Tue, 25 Aug 2020 23:44:52 -0400
Message-Id: <20200826034455.28707-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Because of system-specific EFI firmware limitations,
EFI volatile variables may not be capable of holding the
required contents of the Machine Owner Key (MOK) certificate
store. Therefore, an EFI boot loader may pass the MOK certs
via a EFI configuration table created specifically for this
purpose to avoid this firmware limitation.

An EFI configuration table is a simpler and more robust mechanism
compared to EFI variables and is well suited for one-way passage
of static information from a pre-OS environment to the kernel.

This patch set does not remove the support for loading certs
from the EFI MOK variables into the platform key ring.
However, if both the EFI MOK config table and corresponding
EFI MOK variables are present, the MOK table is used as the
source of MOK certs.

The contents of the individual named MOK config table entries are
made available to user space via read-only sysfs binary files under:

	/sys/firmware/efi/mok-variables/


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

