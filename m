Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF049962F3
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfHTOtC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Aug 2019 10:49:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729260AbfHTOtB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Aug 2019 10:49:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6926CECB419C95654477;
        Tue, 20 Aug 2019 22:47:58 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 20 Aug 2019 22:47:49 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        <jcm@redhat.com>, <linux-kernel@vger.kernel.org>,
        <peter.maydell@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/6 V2] CCIX Protocol error reporting.
Date:   Tue, 20 Aug 2019 22:47:26 +0800
Message-ID: <20190820144732.2370-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Note this will clash with:
[PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor specific HW errors
so a rebase will be needed.

Changes since V1:

Addressed comments from James Morse
- Dropped kernel logging of vendor data. We just push it to the tracepoints.
- Tidied up this cover letter and added information to address questions
  raised. Includes removing questions where James and I agreed ;)

Note, this initial series attempts no 'handling' of errors.
That will follow later.

EFI 2.8 defines a new CPER record Appendix N for CCIX Protocol Error Records
(PER). www.uefi.org

These include Protocol Error Record logs which are defined in the
CCIX 1.0 Base Specification www.ccixconsortium.com.  A public evaluation
version is now available.

Handling of coherency protocol errors is complex and how Linux does this
will take some time to evolve.  For now, fatal errors are handled via the
usual means and everything else is reported.

There are 6 types of error defined, covering:
* Memory errors
* Cache errors
* Address translation unit errors
* CCIX port errors
* CCIX link errors
* Agent internal errors.

These errors are concerned (mostly) wth things happening in the CCIX
protocol layer.  They are parallel to AER errors which should be only
concerned with the PCIe layer (which is underneath CCIX).
The ATS errors break this rule slightly. You may get an error
occurring that results in problems at both layers of the protocol
stack and hence have to handle AER and PER errors simultaneously.

Some of these errors can 'almost' be mapped onto standard existing error
types but only at the loss of information specific to CCIX such as
where in the topology they occurred.

The set includes tracepoints to report the errors to RAS Daemon and a patch
set for RAS Daemon will follow shortly.

Several design decisions that people may disagree with.
1. Reporting of vendor data.  We have little choice but to do this via a
   dynamic array as these blocks can take arbitrary size. I had hoped
   no one would actually use these given the odd mismatch between a
   standard error structure and non standard element, but there are
   already designs out there that do use it. James suggested that
   it made sense to put these in the tracepoints, but we shouldn't spam
   the kernel log with them (done in V2).
2. The trade off between explicit tracepoint fields, on which we might
   want to filter in kernel, and the simplicity of a blob.
   I have gone for having the whole of the block specific to the PER
   error type in an opaque blob.
   The key elements that may be filtered on are the physical address
   and the source and component fields which allow you to identify
   faulty devices. Note that you have to know how the devices were
   enumerated to be able to do so.
3. Defined 6 new tracepoints rather than cramming everything into one.
   * They are all defined by the CCIX specification as independent error
     classes.
   * Many of them can only be generated by particular types of agent.
   * The handling required will vary widely depending on types.
     In the kernel some map cleanly onto existing handling. Keeping the
     whole flow separate will aide this. They vary by a similar amount
     in scope to the RAS errors found on an existing system which have
     independent tracepoints.
   * Separating them out allows for filtering on the tracepoints by
     elements that are not shared between them.
   * Muxing the lot into one record type can lead to ugly code both in
     kernel and in userspace.

Rasdaemon patches posted.
https://www.spinics.net/lists/linux-edac/msg10616.html

The following boilerplate is granting rights to the kernel.
Note that I haven't applied the CCIX copyright notice anywhere in this
series because we aren't quoting from the specification.  That is
much more likely to happen in documentation patches than in code.

Like anything else in this series it is open to comment.

This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
you and other parties that are participating (the "participants") in the
Linux kernel with the understanding that the participants will use CCIX's
name and trademark only when this patch is used in association with the
Linux kernel and associated user space.

CCIX is also distributing this patch to these participants with the
understanding that if any portion of the CCIX specification will be
used or referenced in the Linux kernel, the participants will not modify
the cited portion of the CCIX specification and will give CCIX proper
copyright attribution by including the following copyright notice with
the cited part of the CCIX specification:
"© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Jonathan Cameron (6):
  efi / ras: CCIX Memory error reporting
  efi / ras: CCIX Cache error reporting
  efi / ras: CCIX Address Translation Cache error reporting
  efi / ras: CCIX Port error reporting
  efi / ras: CCIX Link error reporting
  efi / ras: CCIX Agent internal error reporting

 drivers/acpi/apei/Kconfig        |   8 +
 drivers/acpi/apei/ghes.c         |  59 +++
 drivers/firmware/efi/Kconfig     |   5 +
 drivers/firmware/efi/Makefile    |   1 +
 drivers/firmware/efi/cper-ccix.c | 817 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c      |   6 +
 include/linux/cper.h             | 333 +++++++++++++
 include/ras/ras_event.h          | 405 +++++++++++++++
 8 files changed, 1634 insertions(+)
 create mode 100644 drivers/firmware/efi/cper-ccix.c

-- 
2.20.1

