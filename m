Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925B5C0751
	for <lists+linux-efi@lfdr.de>; Fri, 27 Sep 2019 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfI0O00 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Sep 2019 10:26:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727207AbfI0O00 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Sep 2019 10:26:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8REMD2I140239
        for <linux-efi@vger.kernel.org>; Fri, 27 Sep 2019 10:26:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9jpr3yep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Fri, 27 Sep 2019 10:26:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 27 Sep 2019 15:26:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 15:26:17 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8REQF7K42860618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 14:26:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34113A405C;
        Fri, 27 Sep 2019 14:26:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 539D2A405B;
        Fri, 27 Sep 2019 14:26:11 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.207.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 14:26:11 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v6 1/9] dt-bindings: ibm,secureboot: secure boot specific properties for PowerNV
Date:   Fri, 27 Sep 2019 10:25:52 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com>
References: <1569594360-7141-1-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092714-0028-0000-0000-000003A3417C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092714-0029-0000-0000-0000246563D6
Message-Id: <1569594360-7141-2-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270134
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PowerNV represents both the firmware and Host OS secureboot state of the
system via device tree. This patch adds the documentation to give
the definition of the nodes and the properties.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 .../bindings/powerpc/ibm,secureboot.rst       | 76 ++++++++++++++++
 .../devicetree/bindings/powerpc/secvar.rst    | 89 +++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,secureboot.rst
 create mode 100644 Documentation/devicetree/bindings/powerpc/secvar.rst

diff --git a/Documentation/devicetree/bindings/powerpc/ibm,secureboot.rst b/Documentation/devicetree/bindings/powerpc/ibm,secureboot.rst
new file mode 100644
index 000000000000..03d32099d2eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/ibm,secureboot.rst
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+*** NOTE ***
+This document is copied from OPAL firmware
+(skiboot/doc/device-tree/ibm,secureboot.rst)
+************
+.. _device-tree/ibm,secureboot:
+
+ibm,secureboot
+==============
+
+The ``ìbm,secureboot`` node provides secure boot and trusted boot information
+up to the target OS. Further information can be found in :ref:`stb-overview`.
+
+Required properties
+-------------------
+
+.. code-block:: none
+
+    compatible:         Either one of the following values:
+
+                        ibm,secureboot-v1  :  The container-verification-code
+                                              is stored in a secure ROM memory.
+
+                        ibm,secureboot-v2  :  The container-verification-code
+                                              is stored in a reserved memory.
+                                              It described by the ibm,cvc child
+                                              node.
+
+                        ibm,secureboot-v3  :  The container-verification-code
+                                              is stored in a reserved memory.
+                                              It described by the ibm,cvc child
+                                              node. Secure variables are
+                                              supported. `secvar` node should
+                                              be created.
+
+    secure-enabled:     this property exists when the firmware stack is booting
+                        in secure mode (hardware secure boot jumper asserted).
+
+    trusted-enabled:    this property exists when the firmware stack is booting
+                        in trusted mode.
+
+    hw-key-hash:        hash of the three hardware public keys trusted by the
+                        platformw owner. This is used to verify if a firmware
+                        code is signed with trusted keys.
+
+    hw-key-hash-size:   hw-key-hash size
+
+    secvar:             this node is created if the platform supports secure
+                        variables. Contains information about the current
+                        secvar status, see 'secvar.rst'.
+
+Obsolete properties
+-------------------
+
+.. code-block:: none
+
+    hash-algo:          Superseded by the hw-key-hash-size property in
+                        'ibm,secureboot-v2'.
+
+Example
+-------
+
+.. code-block:: dts
+
+    ibm,secureboot {
+        compatible = "ibm,secureboot-v2";
+        secure-enabled;
+        trusted-enabled;
+        hw-key-hash-size = <0x40>;
+        hw-key-hash = <0x40d487ff 0x7380ed6a 0xd54775d5 0x795fea0d 0xe2f541fe
+                       0xa9db06b8 0x466a42a3 0x20e65f75 0xb4866546 0x0017d907
+                       0x515dc2a5 0xf9fc5095 0x4d6ee0c9 0xb67d219d 0xfb708535
+                       0x1d01d6d1>;
+        phandle = <0x100000fd>;
+        linux,phandle = <0x100000fd>;
+    };
diff --git a/Documentation/devicetree/bindings/powerpc/secvar.rst b/Documentation/devicetree/bindings/powerpc/secvar.rst
new file mode 100644
index 000000000000..47793ab9c2a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/secvar.rst
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+*** NOTE ***
+This document is copied from OPAL firmware
+(skiboot/doc/device-tree/secvar.rst)
+************
+.. _device-tree/ibm,secureboot/secvar:
+
+secvar
+======
+
+The ``secvar`` node provides secure variable information for the secure
+boot of the target OS.
+
+Required properties
+-------------------
+
+.. code-block:: none
+
+    compatible:         this property is set based on the current secure
+                        variable scheme as set by the platform.
+
+    status:             set to "fail" if the secure variables could not
+                        be initialized, validated, or some other
+                        catastrophic failure.
+
+    update-status:      contains the return code of the update queue
+                        process run during initialization. Signifies if
+                        updates were processed or not, and if there was
+                        an error. See table below
+
+    secure-mode:        a u64 bitfield set by the backend to determine
+                        what secure mode we should be in, and if host
+                        secure boot should be enforced.
+
+Example
+-------
+
+.. code-block:: dts
+
+    secvar {
+        compatible = "ibm,edk2-compat-v1";
+        status = "okay";
+        secure-mode = "1";
+    };
+
+Update Status
+-------------
+
+The update status property should be set by the backend driver to a value
+that best fits its error condtion. The following table defines the
+general intent of each error code, check backend specific documentation
+for more detail.
+
++-----------------+-----------------------------------------------+
+| update-status   | Generic Reason                                |
++-----------------|-----------------------------------------------+
+| OPAL_SUCCESS    | Updates were found and processed successfully |
++-----------------|-----------------------------------------------+
+| OPAL_EMPTY      | No updates were found, none processed         |
++-----------------|-----------------------------------------------+
+| OPAL_PARAMETER  | Unable to parse data in the update section    |
++-----------------|-----------------------------------------------+
+| OPAL_PERMISSION | Update failed to apply, possible auth failure |
++-----------------|-----------------------------------------------+
+| OPAL_HARDWARE   | Misc. storage-related error                   |
++-----------------|-----------------------------------------------+
+| OPAL_RESOURCE   | Out of space (somewhere)                      |
++-----------------|-----------------------------------------------+
+| OPAL_NO_MEM     | Out of memory                                 |
++-----------------+-----------------------------------------------+
+
+Secure Mode
+-----------
+
++-----------------------+------------------------+
+| backend specific-bits |      generic mode bits |
++-----------------------+------------------------+
+64                     32                        0
+
+The secure mode property should be set by the backend driver. The least
+significant 32 bits are reserved for generic modes, shared across all
+possible backends. The other 32 bits are open for backends to determine
+their own modes. Any kernel must be made aware of any custom modes.
+
+At the moment, only one general-purpose bit is defined:
+
+``#define SECVAR_SECURE_MODE_ENFORCING  0x1``
+
+which signals that a kernel should enforce host secure boot.
-- 
2.20.1

